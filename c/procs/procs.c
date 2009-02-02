#ifdef HAVE_CONFIG_H
#include "config.h"
#endif

#include <stdio.h>
#include <stdlib.h>
#include <errno.h>

#ifdef HAVE_SYS_PARAM_H
#include <sys/param.h>
#endif

#ifdef HAVE_SYS_PROC_H
#include <sys/proc.h>
#endif

#ifdef HAVE_SYS_SYSCTL_H
#include <sys/sysctl.h>
#endif

#ifdef HAVE_DIRENT_H
#include <dirent.h>
#endif

#ifdef HAVE_NDIR_H
#include <ndir.h>
#endif

static const char progname[] = PACKAGE_NAME;
static int print_process_id_list();

#include <sys/types.h>
#include <dirent.h>

#ifdef HAVE_STRUCT_KINFO_PROC
int print_process_id_list(void)
{
    static int mibs[] = {CTL_KERN, KERN_PROC, KERN_PROC_ALL};
    size_t buf_size = 0;
    size_t cnt;
    struct kinfo_proc *items;

    if (sysctl(mibs, sizeof(mibs) / sizeof(mibs[0]), 0, &buf_size, 0, 0)) {
        perror(progname);
        return 1;
    }

    items = malloc(buf_size);
    if (!items) {
        errno = ENOMEM;
        perror(progname);
        return 1;
    }

    if (sysctl(mibs, sizeof(mibs) / sizeof(mibs[0]), items, &buf_size, 0, 0)) {
        perror(progname);
        return 1;
    }

    for (cnt=0; cnt < buf_size / sizeof(items[0]);++cnt) {
        printf("%d\n", items[cnt].kp_proc.p_pid);
    }

    free(items);
    return 0;
}
#elif HAVE__PROC
int print_process_id_list(void)
{
    DIR *dir = opendir("/proc");
    if (!dir) {
	perror(progname);
	return 1;
    }

    for (;;) {
	struct dirent *ent = readdir(dir);
	int pid;
	if (!ent) break;
	if (sscanf(ent->d_name, "%d", &pid) > 0)
	    printf("%d\n", pid);
    }
    if (errno) {
	perror(progname);
	closedir(dir);
	return 1;
    }
    closedir(dir);
    return 0;
}
#endif

int main(void)
{
    print_process_id_list();
    return 0;
}
