#if	!defined( __tsx__action__ )
#	 define	  __tsx__action__

#include <tsx/prefix.h>
#include <tsx/display.h>

namespace	tsx{

	class	Handler{
	public:
		typedef	int	(*Caller)(void *, void *, void *);

				 Handler();
				 Handler(Caller, void *, void *, void *);
				~Handler();

		void		set(Caller, void *, void *, void *);
		void		clear();

	int	operator	() (void);
	int	operator	() (void *);
	int	operator	() (void *, void *);
	int	operator	() (void *, void *, void *);

	bool	operator	== (const Handler &);
	bool	operator	!= (const Handler &);

	protected:
		Caller		call;
		void	*	p1;
		void	*	p2;
		void	*	p3;
	private:
	};


	class	Action{
	public:
typedef	std::list<Handler>	HandlerList;
typedef	std::list<uint>		OrderList;

				 Action();
				~Action();

		bool		connect(Handler::Caller, void *, void *, void *);
		bool		disconnect(Handler::Caller);
		
		// ordered list must be the same size as count //
		bool		assign_callorder(OrderList);
		OrderList	callorder()	const;

		uint		count()	const;

		void		name(const std::string &);
		std::string	name()	const;

std::list<int>	operator	() (void);
	bool	operator	== (const Action &);
	bool	operator	!= (const Action &);
const Action &	operator	 = (const Action &);

	protected:
		std::string	title;
		HandlerList	hlist;
		OrderList	olist;
	private:
	};

}

#endif	// end __tsx__action__
