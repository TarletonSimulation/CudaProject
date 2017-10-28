#if	!defined( __tsx__application__ )
#	 define	  __tsx__application__

#include <tsx/display.h>
#include <tsx/widget.h>

namespace	tsx{
	
	class	Application
	:	public	Widget{
		public:
				 Application(int, char **);
				~Application();

		std::string *	argv();
			int	argc();


		protected:
			bool	xrun;

			int	xargc;
		std::string *	xargv;
		private:
	};

}


#endif
