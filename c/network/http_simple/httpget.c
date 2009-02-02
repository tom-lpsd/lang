#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include <sys/time.h>
#include <pwd.h>
#include <netdb.h>
#include <errno.h>
#include <unistd.h>
#include <sys/types.h>
#include <sys/stat.h>
#include <sys/param.h>
#include <sys/socket.h>
#include <netinet/in.h>
#include <netinet/tcp.h>
#include <arpa/inet.h>
#include <stdarg.h>

int SOCprintf(int, char *, ...);

int main(int argc, char *argv[])
{
    char buf[512];
    char host[MAXHOSTNAMELEN], *path, *ptr;
    int i;

    if (argc <= 1) {
	fprintf(stderr, "httpget host:path ... \n");
	exit(-1);
    }

    for (i=1;i<argc;i++){
	strcpy(buf, argv[i]);
	ptr = strtok(buf, ":");
	if((path=strtok(NULL,":"))==NULL) {
	    strcpy(host, "localhost");
	    path = ptr;
	} else {
	    strcpy(host, ptr);
	}
	DoHttpGet(host, path);
    }
    return 0;
}

int DoHttpGet(char *host, char *path)
{
  int soc;
  char *ptr;

  fprintf(stderr, "host=%s, path=%s\n",host,path);

  if((soc=ConnectHost(host,"http",80))==-1){
    fprintf(stderr, "Cannot connect to %s http.\n",host);
    exit(-1);
  }

  if(path[0]!='/'){
    SOCprintf(soc, "GET /%s HTTP/1.0\r\n\r\n", path);
  }
  else {
    SOCprintf(soc, "GET %s HTTP/1.0\r\n\r\n", path);
  }

  if((ptr=strrchr(path, '/'))!=NULL) {
    if(strlen(ptr+1)==0) {
      SOCrecvDataToFile(soc, "noname");
    }
    else {
      SOCrecvDataToFile(soc, ptr+1);
    }
  } else {
    SOCrecvDataToFile(soc,path);
  }

  SocketClose(soc);

  return 0;
}

short short_conv(short s)
{
  union {
    short i;
    struct {
      unsigned char a;
      unsigned char b;
    } s;
  } i_s, i_s_ret;

  i_s.i = s;
  i_s_ret.s.a = i_s.s.b;
  i_s_ret.s.b = i_s.s.a;

  return (i_s_ret.i);
}

int ConnectHost(char *host, char *port, int portno)
{
  struct hostent *servhost;
  struct servent *se;
  struct sockaddr_in server;
  int soc, p;

  if((servhost=gethostbyname(host))==NULL) {
    u_long addr;
    addr = inet_addr(host);
    servhost = gethostbyaddr((char*)&addr, sizeof(addr), AF_INET);
    if(servhost == NULL) {
      perror("Error:gethostbyaddr");
      return (-1);
    }
  }

  if((se=getservbyname(port,"tcp"))==NULL){
  }

  if((soc=socket(AF_INET, SOCK_STREAM, 0))<0) {
    perror("socket");
    return -1;
  }
  memset((char*)&server, 0, sizeof(server));
  server.sin_family=AF_INET;
  if(se==NULL) {
    if((p=atoi(port))==0) {
      p=portno;
    }
    server.sin_port = short_conv(p);
  } else {
    server.sin_port = se->s_port;
  }
  memcpy((char*)&server.sin_addr,
	 servhost->h_addr, servhost->h_length);

  if(connect(soc, (struct sockaddr*)&server, sizeof(server))==-1) {
    perror("connect");
    SocketClose(soc);
    return -1;
  }

  return (soc);
}

int SocketClose(int soc)
{
  int ret;
  
  shutdown(soc, 2);
  ret = close(soc);
  return (ret);
}

int SOCprintf(int soc, char *fmt, ...)
{
  va_list args;
  char buf[4096];

  va_start(args, fmt);
  vsprintf(buf, fmt, args);
  vfprintf(stderr, fmt, args);
  va_end(args);

  send(soc, buf, strlen(buf), 0);

  return 0;
}

int SOCrecv(int soc, char *buf)
{
  int size;
  
  size = recv(soc, buf, 1024, 0);
  buf[size] = '\0';
  fprintf(stderr, ">>>>>%s\n", buf);
  
  return size;
}

char *memstr(char *buf, int blen, char *target, int tlen)
{
  int i,j,ok;

  for(i=0;i<blen;i++){
    if(buf[i] == target[0]) {
      ok = 1;
      for(j=1;j<tlen;j++){
	if(buf[i+j] != target[j]){
	  ok=0;
	  break;
	}
      }
      if(ok==1){
	return (buf+i);
      }
    }
  }

  return NULL;
}

int SOCrecvDataToFile(int soc, char *filename)
{
  int width;
  struct timeval timeout;
  fd_set readOK, mask;
  char tmpbuf[8193], *ptr;
  int size, end, head;
  FILE *fp;
  
  if((fp=fopen(filename, "w"))==NULL) {
    perror("fopen");
    return -1;
  }

  FD_ZERO(&mask);
  FD_SET(soc, &mask);
  width = soc + 1;
  timeout.tv_sec = 1;
  timeout.tv_usec = 0;
  head = 0;
  end = 0;

  while(1) {
    readOK = mask;
    switch(select(width, &readOK, NULL, NULL, &timeout)) {
    case -1:
      if(errno != EINTR) {
	perror("select");
	end = 1;
      }
      break;
    case 0:
      break;
    default:
      if(FD_ISSET(soc, &readOK)) {
	size = recv(soc, tmpbuf, 8192, 0);
	if(size <= 0) {
	  end = 1;
	}
	else {
	  if (head == 0) {
	    ptr = memstr(tmpbuf, size, "\r\n\r\n", 4);
	    if(ptr!=NULL) {
	      fwrite(tmpbuf, ptr-tmpbuf+4, 1, stderr);
	      head = 1;
	      fwrite(ptr+4, size-(ptr-tmpbuf)-4, 1, fp);
	    }
	    else {
	      fwrite(tmpbuf, size, 1, stderr);
	    }
	  }
	}
      }
      break;
    }
    if(end == 1){
      break;
    }   
  }
  
  fclose(fp);
  return 0;
}
