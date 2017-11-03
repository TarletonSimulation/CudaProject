#if	!defined( __tsx__file__ )
#	 define	  __tsx__file__

#include <tsx/prefix.h>
#include <tsx/bits/file.h>

extern "C"{
#include <sys/types.h>
#include <sys/stat.h>
#include <sys/file.h>
#include <sys/time.h>

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










	class	File{
		public:
				 File();
				 File(const std::string &);
				~File();

	// return file name //
	static	std::string	name(const File &);
		std::string	name()	const;
	
	// return file owner name //
	static	std::string	owner(const File &);
		std::string	owner()	const;
	
	// return file group name //
	static	std::string	group(const File &);
		std::string	group()	const;

	// open file return file descriptor //
		static	int	open(File &, const std::string &, ulong, mode_t =0);
		static	int	open(File &);
			int	open(const std::string &, ulong, mode_t =0);
			int	open();

	// close file // return true on success //
		static	bool	close(File &);
			bool	close();

	// true if the file is open //
		static	bool	is_open(const File &);
			bool	is_open()	const;

	// write to file // return number of bytes written //
		static	int	write(File &, const void *, size_t, size_t);
			int	write(const void *, size_t, size_t);

	// read from file // return number of bytes read //
		static	int	read(File &, void *, size_t, size_t);
			int	read(void *, size_t, size_t);

	// check for file lock in file system // future use //
		static	bool	has_lock(const File &);
			bool	has_lock()	const;

		protected:
			int	desc;	// file descriptor //
		std::string	fname;	// file name //
			mode_t	fmode;	// file mode //
			ulong	fflag;	// file flags //
			bool	fob;	// file opened boolean //
		private:
	};




}


#endif	// end __tsx__file__
