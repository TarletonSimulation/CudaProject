#if	!defined( __tsx__widget__ )
#	 define	  __tsx__widget__

#include <tsx/prefix.h>
#include <tsx/display.h>
#include <tsx/action.h>

namespace	tsx{

	class	widget_base
	:	public	winfo_t{
		public:
				 widget_base();
				 widget_base(const Rectangle &, const Point &);
				~widget_base();

			bool	showing()	const;
			bool	created()	const;

			void	hide();
			void	destroy();

			int	on_key_press();
			int	on_key_release();

			int	on_button_press();
			int	on_button_release();

			int	on_expose();

			bool	needs_reconf();
			bool	needs_resize();
			bool	needs_repos();
		protected:
		private:
	};


	class	Widget
	:	public	widget_base{
		public:
				 Widget();
				~Widget();
		protected:
		private:
	};

}

#endif	// end __tsx__widget__
