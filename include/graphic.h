#if	!deifned( __tsx__graphic__ )
#	 define	  __tsx__graphic__

#include <tsx/prefix.h>
#include <tsx/display.h>
#include <tsx/bits/widget.h>

namespace	tsx{


	class	Graphic{
		public:
				 Graphic();
				~Graphic();
		protected:
		GC		xgc;
		XGCValues *	xgc_values;

		Visual	*	xvisual;
		XVisualInfo *	xvis_info;

		bool		gact;		// graphic active value //
		private:
			void	load_default_graphic();
	};


}


#endif	// end __tsx__graphic__
