#include <stdio.h>
#include <stdlib.h>
#include <X11/Xlib.h>
#include <GL/gl.h>
#include <GL/glu.h>
#include <GL/glx.h>

#include <unistd.h>

struct GLWindow {
        Display*                        dpy;
        Window                          win;
        Window                          root;
        GLXFBConfig*                    fbConfigs;
        GLXWindow                       glxWin;
        GLXContext                      ctx;
        XVisualInfo*                    vi;
        Colormap                        cmap;
        XSetWindowAttributes            swa;
        int                             width;
        int                             height;
} GLWindow;
 
void init(int w, int h){
        /********************/
        /* ===== XLIB ===== */
        /********************/
       
        /* Open display */
        GLWindow.dpy = XOpenDisplay(NULL);
       
        if(GLWindow.dpy == NULL) {
                printf("Could not connect to an X server\n");
                exit(0);
        }
       
        /* Retrieve a mode */
        int doubleBufferAttributes[] = {
                GLX_DRAWABLE_TYPE, GLX_WINDOW_BIT,
                GLX_RENDER_TYPE,
                GLX_RGBA_BIT,
                GLX_DOUBLEBUFFER,  True,
                GLX_RED_SIZE,      1,
                GLX_BLUE_SIZE,     1,
                None
        };
       
        GLWindow.root = DefaultRootWindow(GLWindow.dpy);
       
        int numReturned = 0;
        GLWindow.fbConfigs = glXChooseFBConfig( GLWindow.dpy, DefaultScreen(GLWindow.dpy), doubleBufferAttributes, &numReturned );
       
        if ( GLWindow.fbConfigs == NULL ) {
                printf( "No double buffered config available\n" );
                exit( EXIT_FAILURE );
        }
       
        GLWindow.vi = glXGetVisualFromFBConfig(GLWindow.dpy, GLWindow.fbConfigs[0]);
       
        if(GLWindow.vi == NULL) {
                printf("No appropriate visual found\n");
                exit(0);
        }
       
        GLWindow.cmap = XCreateColormap(GLWindow.dpy, GLWindow.root, GLWindow.vi->visual, AllocNone);
        GLWindow.swa.colormap = GLWindow.cmap;
        GLWindow.swa.event_mask = ExposureMask | KeyPressMask;
       
        /* Create a window */
        GLWindow.win = XCreateWindow(GLWindow.dpy, GLWindow.root, 0, 0, w, h, 0, GLWindow.vi->depth, InputOutput, GLWindow.vi->visual, CWColormap | CWEventMask, &GLWindow.swa);
       
        XMapWindow(GLWindow.dpy, GLWindow.win);
        XStoreName(GLWindow.dpy, GLWindow.win, "ImageBrowser");
       
        /* Create an OpenGL context */
        GLWindow.ctx = glXCreateContext(GLWindow.dpy, GLWindow.vi, NULL, GL_TRUE);
        glXMakeCurrent(GLWindow.dpy, GLWindow.win, GLWindow.ctx);
       
        /* Store the size */
        GLWindow.width = w;
        GLWindow.height = h;
 
        /********************/
        /* ==== OpenGL ==== */
        /********************/
       
        /* Viewport related */
        glViewport(0, 0, w, h);
       
        glMatrixMode(GL_PROJECTION);
        glLoadIdentity();
 
        gluPerspective(45.0f,(GLfloat)w/(GLfloat)h,0.1f,100.0f);
 
        glMatrixMode(GL_MODELVIEW);
        glLoadIdentity();
       
        /* Settings */
        glEnable(GL_TEXTURE_2D);
        glShadeModel(GL_SMOOTH);
        glClearColor(1.0f, 1.0f, 0.0f, 0.0f);
        glClearDepth(1.0f);
        glEnable(GL_DEPTH_TEST);
        glDepthFunc(GL_LEQUAL);
        glHint(GL_PERSPECTIVE_CORRECTION_HINT, GL_NICEST);
        glClearStencil(0);
       
        glEnable(GL_CULL_FACE);
}
 
int main (int argc, const char* argv[]){
        init(640,480);
	sleep(3);
        return 0;
}
