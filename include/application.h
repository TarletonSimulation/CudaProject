#if	!defined( __tsx_application__ )
#	 define	  __tsx_application__

#include <tsx/prefix.h>
#include <tsx/display.h>
#include <tsx/widget.h>

namespace tsx{

	struct	xApp
	:	public xWidget,
		public xDisplay{
		public:
			 xApp(int, char **);
			~xApp();

		xWidget &	widget();

			int	start();
			int	stop();
			bool	running();
			bool	destroy();

			void	width(unsigned int);
		unsigned int	width();
			
			void	height(unsigned int);
		unsigned int	height();
			
			void	x(int);
			int	x();

			void	y(int);
			int	y();

			int	next_event();
			int	event_type();
		Drawable	event_window();
			
			void	flush();

		protected:
			int	argc;
		std::string *	argv;
			
			pid_t	proc_id;
			
			bool	looped;	// main loop value //
	};

}

#endif
