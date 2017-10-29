#if	!defined( __tsx__program__ )
#	 define	  __tsx__program__

#include <tsx/prefix.h>

extern "C"{
#include <sys/socket.h>
}

namespace	tsx{

	// argument safety //
	class	Argument{
		public:
				 Argument(int, char **);
				~Argument();

std::string	operator	[] (uint);	// return specified argument //

		protected:
			int	largc;		// local argument count //
		std::string *	largs;		// local arguments //
		private:
	};


	// program safety //
	class	Program
	:	public	Argument{
		public:
				 Program(int, char **);
				 Program(const Argument &);
				~Program();
		protected:

	std::list<std::string>	prog_list;	// file names to possibly be loaded //

			int	pin[2];		// pipe input //
			int	pout[2];	// pipe output//
			int	perr[2];	// pipe error //

		private:
	};

}

#endif	// __tsx__program__
