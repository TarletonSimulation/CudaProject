#if	!defined( __tsx__application__ )
#	 define	  __tsx__application__

#include <tsx/display.h>
#include <tsx/widget.h>

namespace	tsx{
	
	class	Application
	:	public	Widget,
		public	xDisplay{
		public:
				 Application(int, char **);
				~Application();

		std::string *	argv();
			int	argc();

			bool	running()	const;

			bool	start();	// main loop //
			bool	stop();

		protected:
			bool	xrun;

			int	xargc;
		std::string *	xargv;
		private:
	};

}


#endif
