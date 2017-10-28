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

			bool	connect_action(const std::string &, Handler::Caller, void *, void *);
			bool	disconnect_action(const std::string &, Handler::Caller);

			bool	create_action(const std::string &, Handler::Caller, void *, void *);
			bool	destroy_action(const std::string &);

const	Widget::ActionList &	actions()	const;
			uint	action_count()	const;
	Widget::ActionList &	actions_ref();
	Widget::ActionList *	actions_pointer();
		
	const	Widget	&	widget()	const;
		Widget	&	widget_ref();
		Widget	*	widget_pointer();

		std::list<int>	operator	()(const std::string &);

		std::string *	argv();
			int	argc();

			bool	running()	const;

			bool	start();	// start main loop //
			bool	stop();		// stop main loop //

		protected:
			bool	xrun;

			int	xargc;
		std::string *	xargv;
		private:
	};

}


#endif
