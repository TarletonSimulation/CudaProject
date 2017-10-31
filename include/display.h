#if	!defined( __tsx__display__ )
#	 define	  __tsx__display__

#include <tsx/geometry.h>

extern "C"{
#include <X11/Xlib.h>
#include <X11/X.h>
#include <X11/Xos.h>
#include <X11/Xresource.h>
#include <X11/Xatom.h>
#include <X11/keysym.h>
#include <X11/keysymdef.h>

#include <GL/gl.h>
#include <GL/glu.h>
#include <GL/glx.h>
}

namespace	tsx{

	class	xDisplay{
	public:
				 xDisplay(const std::string & ="");
				~xDisplay();

			void	connect(const std::string &);
			void	connect();
			void	disconnect();

			bool	connected()		const;
			int	connection()		const;

		std::string	server_name()		const;
		std::string	screen_name()		const;
			int	screen_number()		const;
			int	screen_count()		const;

	const	Rectangle &	geometry();
		int		width()			const;
		int		height()		const;
		Window		root()			const;
		Display	*	display_pointer()	const;
		Screen	*	screen_pointer()	const;
		Visual	*	visual()		const;
		int		depth()			const;

	protected:
		Rectangle	xgeom;	// display size
		std::string	xname;	// server name
		Display	*	xserv;	// display pointer
		Window		xroot;	// root window to connection
		Screen	*	xscrn;	// current screen pointer
		int		xnumb;	// screen number
		bool		xconn;	// true when connected to display
	private:
	};


	struct	winfo_t{
	Window			window;
	Rectangle		geometry;
	Point			at;
	Colormap		colormap;
	XVisualInfo	*	vis_info;	// dont know about right here //
	GLint		*	gl_iarr;
	GLfloat		*	gl_farr;
	GLXContext		glx_context;
	int			xclass;		// InputOutput, OutputOnly, CopyFromParent //
	bool			created;
	bool			mapped;
	bool			update;
	bool			active;
	bool			blocking;
	bool			resize_needed;
	bool			repos_needed;
	};



}

#endif
