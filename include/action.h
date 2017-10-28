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
	int	operator	() (void *&);
	int	operator	() (void *&, void *&);
	int	operator	() (void *&, void *&, void *&);

	bool	operator	== (const Handler &);
	bool	operator	!= (const Handler &);

	protected:
		std::string	name;	// handler name //
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
	
	static	OrderList	Unordered();	// just returns an list containing the unsigned int of -1 // max unsigned integer //

	static	Action		create_action(Handler::Caller, void *, void *, void *);
	static	Action		create_action(HandlerList, OrderList);

	static	Action	*	create_action_pointer(Handler::Caller, void *, void *, void *);
	static	Action	*	create_action_pointer(HandlerList, OrderList);

		bool		connect(Handler::Caller, void *, void *, void *);
		bool		disconnect(Handler::Caller);
		
		// ordered list must be the same size as count //
		bool		assign_callorder(OrderList);
		OrderList	callorder()	const;
		void		remove_callorder();

		uint		count()	const;

		void		name(const std::string &);
		std::string	name()	const;

std::list<int>	operator	() (void);
std::list<int>	operator	() (void *&, void *&, void *&);
	bool	operator	== (const Action &);
	bool	operator	!= (const Action &);
const Action &	operator	 = (const Action &);
	
	const	Action	&	action();
		Action	&	action_ref();
		Action	*	action_pointer();

	protected:
		std::string	group;	// action group name //
		HandlerList	hlist;
		OrderList	olist;
	private:
	};

}

#endif	// end __tsx__action__
