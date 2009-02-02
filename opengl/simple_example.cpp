#include <GL/glut.h>
#include <GL/glu.h>
#include <GL/gl.h>
#include <string>
#include <sstream>
#include <assert.h>

static const int QUIT_VALUE(90);

GLuint listID;

static void display()
{
	glClear(GL_COLOR_BUFFER_BIT);
	
	glLoadIdentity();
	glTranslatef(0.f, 0.f, -4.f);
	
	glCallList(listID);
	
	glutSwapBuffers();
	
	assert(glGetError()==GL_NO_ERROR);
}

static void reshape(int w, int h)
{
	glViewport(0, 0, w, h);
	
	glMatrixMode(GL_PROJECTION);
	glLoadIdentity();
	gluPerspective(50., (double)w/(double)h, 1., 10.);
	
	glMatrixMode(GL_MODELVIEW);
	assert(glGetError()==GL_NO_ERROR);
}

static void mainMenuCB(int value)
{
	if (value==QUIT_VALUE)
		exit(0);
}

static void init()
{
	glDisable(GL_DITHER);
	
	std::string ver((const char*)glGetString(GL_VERSION));
	assert(!ver.empty());
	std::istringstream verStream(ver);
	
	int major, minor;
	char dummySep;
	verStream >> major >> dummySep >> minor;
	const bool useVertexArrays = ((major>=1) && (minor>=1));
	
	const GLfloat data[] = {
		-1.f, -1.f, 0.f,
		1.f, -1.f, 0.f,
		0.f, 1.f, 0.f};
	
	if (useVertexArrays) {
		glEnableClientState(GL_VERTEX_ARRAY);
		glVertexPointer(3, GL_FLOAT, 0, data);
	}
	
	listID = glGenLists(1);
	glNewList(listID, GL_COMPILE);
	
	if (useVertexArrays)
		glDrawArrays(GL_TRIANGLES, 0, 3);
	else
	{
		glBegin(GL_TRIANGLES);
		glVertex3fv(&data[0]);
		glVertex3fv(&data[3]);
		glVertex3fv(&data[6]);
		glEnd();
	}
	
	glEndList();
	
	assert(glGetError()==GL_NO_ERROR);
	
	glutDisplayFunc(display);
	glutReshapeFunc(reshape);
	
	glutCreateMenu(mainMenuCB);
	glutAddMenuEntry("Quit", QUIT_VALUE);
	glutAttachMenu(GLUT_RIGHT_BUTTON);
}

int main(int argc, char *argv[])
{
	glutInit(&argc, argv);
	
	glutInitDisplayMode(GLUT_RGB|GLUT_DOUBLE);
	glutInitWindowSize(300, 300);
	glutCreateWindow("Simple Example");
	
	init();
	
	glutMainLoop();
	
	return 0;
}

