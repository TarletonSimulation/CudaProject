#include <tsx/file.h>

namespace	tsx{

	
	User::User(){
		uname	= "";
		uid	= 0ul;
	}

	User::~User(){
	}






	Group::Group(){
		gname	= "";
		gid	= 0ul;
	}

	Group::~Group(){
	}







	File::Lock::Lock(){
		begin	= -1;
		end	= -1;
		mode	=  0;
	}

	File::Lock::~Lock(){
	}
	

	bool
	File::Lock::operator == ( const File::Lock & lock ){
		if( begin isnot lock.begin )
			return	false;
	else	if( end isnot lock.end )
			return	false;
	else	if( mode isnot lock.mode )
			return	false;
		else	return	false;
	}

	bool
	File::Lock::operator != ( const File::Lock & lock ){
		return	( (*this is lock) isnot true );
	}

	const File::Lock &
	File::Lock::operator = ( const File::Lock & lock ){
		begin	= lock.begin;
		end	= lock.end;
		mode	= lock.mode;
	return	*this;
	}






	File::File()
	:	flock(){
		fname		= "";
		fmode		= 0;
		fflags		= 0;

		fopened		= false;
		flock_init	= false;
	}

	File::~File(){
		if( is_open() ){
			close();
		}
	}



	bool
	File::open(const std::string & file, int flags, mode_t mode){
		if( is_open() is true )
			return	false;

		fname = file;

		// *NOTES* //
		/*
			+ create conditions that prevent users from using obfuscated masks +
			+ + for both flags and file modes + +
		*/
		fmode = mode;
		fflags= flags;

		if( mode is 0 ){
			fdesc	= lnx_open(fname, fflags);
		}else{
			fdesc	= lnx_open(fname, fflags, fmode);
		}

		if( fdesc lt 0 )
			return	false;

		fopened = true;
	return	true;
	}

	bool
	File::open()
	{return	open(fname,fflags,fmode);}

	bool
	File::close(){
		if( is_open() is true ){
			fdesc = lnx_close(fdesc);
			if( fdesc is 0 ){
				fopened = false;
				return	true;
		}else	if( fdesc lt 0 )
			return	false;
		}return	false;
	}

	bool
	File::is_open()
	const{return ((fopened is true) and (fdesc gt 2));}

	const std::string &
	File::name()
	const{return fname;}



}
