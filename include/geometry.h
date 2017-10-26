#if	!defined( __tsx_rectangle__ )
#	 define	  __tsx_rectangle__

#include <tsx/prefix.h>

namespace tsx{
	

	// for x11 // and general integer sized rectangles //
	class	Rectangle{
		public:
				 Rectangle();
				 Rectangle(uint, uint);
				 Rectangle(const Rectangle &);
				~Rectangle();
	
	// commonly used names // for lists and such //
	static	Rectangle	create(uint, uint);
	static	Rectangle	create(const Rectangle &);
	static	Rectangle *	create_pointer(uint, uint);
	static	Rectangle *	create_pointer(const Rectangle &);

friend	const	Rectangle &	add(const Rectangle &, const Rectangle &);
friend	const	Rectangle &	add_to(Rectangle &, const Rectangle &);

friend	const	Rectangle &	sub(Rectangle &, const Rectangle &);
friend	const	Rectangle &	sub_from(Rectangle &, const Rectangle &);

friend	const	Rectangle &	scale(Rectangle &, float);			// floating point because it can be scaled downward //
friend	const	Rectangle &	scale_width(Rectangle &, float);
friend	const	Rectangle &	scale_height(Rectangle &, float);

// final parameters are for shared objects // min_ptr, max_ptr, iter_ptr are shared //
friend	bool			copy(Rectangle &, const Rectangle &, bool =false, bool =false, bool =false);

			void	width(uint);
			uint	width()			const;

			void	height(uint);
			uint	height()		const;

			uint	area()			const;

			void	rectangle(uint, uint);
			void	rectangle(const Rectangle &);

		// future inheritance methods //
		// return copies of values //
	const	Rectangle &	rectangle()		const;

		// pointers for inherited reasons //
		Rectangle *	rectangle_pointer();

		// reference returns // becuase c++... //
		Rectangle &	rectangle_ref();
			
			bool	has_limits()		const;
			bool	has_max()		const;
			bool	has_min()		const;


		bool 		operator	== ( const Rectangle & );
		bool 		operator	!= ( const Rectangle & );
	const	Rectangle &	operator	+= ( const Rectangle & );
	const	Rectangle &	operator	-= ( const Rectangle & );
	const	Rectangle &	operator	 = ( const Rectangle & );
	const	Rectangle &	operator	 + ( const Rectangle & );
	const	Rectangle &	operator	 - ( const Rectangle & );

		protected:
			uint	w, h;		// width height //
			bool	limit_block;

		private:
			void	init_limits();
			void	init_max();
			void	init_min();

			void	remove_max();
			void	remove_min();
			void	remove_limits();

			struct limits{
				struct max{
					uint * width, * height;
					bool	is_sharing;
				};

				struct min{
					uint * width, * height;
					bool	is_sharing;
				}min;
			};
	};




}

#endif
