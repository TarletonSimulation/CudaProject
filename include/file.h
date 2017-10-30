#if	!defined( __tsx__file__ )
#	 define	  __tsx__file__

#include <tsx/prefix.h>

extern "C"{
#include <sys/types.h>
#include <sys/stat.h>
#include <sys/file.h>

#include <fcntl.h>
#include <pwd.h>
#include <grp.h>
}


namespace	tsx{


	// wrappers to put linux file functions into tsx namespace //
	inline
	int	lnx_close(int f)
	{return	close(f);}

	inline
	int	lnx_open(const std::string & name, int flags)
	{return	open(name.c_str(),flags);}

	inline
	int	lnx_open(const std::string & name, int flags, mode_t mode)
	{return open(name.c_str(),flags,mode);}

	inline
	int	lnx_openat(int dir, const std::string & name, int flags, mode_t mode)
	{return	openat(dir,name.c_str(),flags,mode);}

	inline
	int	lnx_openat(int dir, const std::string & name, int flags)
	{return	openat(dir,name.c_str(),flags);}

	inline
	int	lnx_creat(const std::string & name, mode_t mode)
	{return	creat(name.c_str(),mode);}

	inline
	int	lnx_stat(const std::string & name, struct stat * buf)
	{return	stat(name.c_str(),buf);}

	inline
	int	lnx_fstat(int desc, struct stat * buf)
	{return	fstat(desc,buf);}

	inline
	int	lnx_lstat(const std::string & name, struct stat * buf)
	{return	lstat(name.c_str(),buf);}

	inline
	int	lnx_fstatat(int dirfd, const std::string & name, struct stat * buf, int flags)
	{return	fstatat(dirfd, name.c_str(),buf,flags);}










	class	User{
		public:
				 User();
				 User(const std::string &, ulong);
				~User();

			ulong	id();
		std::string	name();

	bool	operator	== (const User &);
	bool	operator	!= (const User &);
const	User &	operator	 = (const User &);

		protected:
		std::string	uname;
			ulong	uid;
		private:
	};

	
	class	Group{
		public:
	typedef	std::list<User>	Members;

				 Group();
				 Group(const std::string &, ulong);
				~Group();

			bool	create_new_user(const std::string &);
			
			ulong	id()		const;
			ulong	uid(const std::string &)
						const;
		std::string	name()		const;

		Members		members()	const;

	bool	operator	== (const Group &);
	bool	operator	!= (const Group &);
const	Group &	operator	 = (const Group &);

		protected:
		ulong		gid;
		std::string	gname;
		Members		gusers;		// users in group //
		private:
	};


	class	File{
		public:

		struct	Lock{
				 Lock();
				~Lock();

			int	begin;		// will not read or write from here // if -1 no lock will be applied //
			int	end;		// will lock up to this point // if -1 locks from beginning bit to end of file //
			ulong	mode;		// locking mode //

		bool	operator == (const Lock &);
		bool	operator != (const Lock &);
	const	Lock &	operator  = (const Lock &);
		};

				 File();
				 File(const std::string &);
				~File();

	static		bool	is_open(const File &);
			bool	is_open()	const;
	
	static		bool	open(File &);
			bool	open();
	
	static		bool	reopen(File &);
			bool	reopen();

	static		bool	open(File &, const std::string &, int =0, mode_t =0);
			bool	open(const std::string &, int =0, mode_t =0);

	static		bool	close(File &);
			bool	close();

static	const	std::string &	name(const File &);
	const	std::string &	name()		const;

	static		bool	rename(File &, const std::string &);
			bool	rename(const std::string &);

	static		User	owner(const File &);
			User	owner()		const;
	
	static		Group	group(const File &);
			Group	group()		const;

			Lock	new_lock(int, int);
			Lock &	get_lock();
		const	Lock &	copy_lock()	const;
			
			bool	lock_applied()	const;
			void	lock(bool =true);
			void	release_lock();

	static		int	read(File &, void *&, size_t);
			int	read(void *, size_t);
	
	static		int	write(File &, const void *&, size_t);
			int	write(const void *&, size_t);


	bool	operator	== (const File &);
	bool	operator	!= (const File &);
const	File &	operator	 = (const File &);

		protected:
		std::string	fname;
		mode_t		fmode;
		int		fflags;
		Lock		flock;
		int		fdesc;

		bool		fopened;
		bool		flock_init;
		private:
	};





}


#endif	// end __tsx__file__
