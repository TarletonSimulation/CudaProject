#if	!defined( __tsim__ )
#	 define	  __tsim__

#if	 defined( __cplusplus )
extern "C"{
#endif

#include <stdio.h>
#include <stdlib.h>
#include <stdarg.h>
#include <unistd.h>
#include <float.h>
#include <sys/types.h>

#if	 defined( __cplusplus )
}

#include <iostream>
#include <iomanip>
#include <string>
#include <list>

#endif


#if	!defined	GPU
#	 define		GPU	__global__
#endif

#if	!defined	DEVICE
#	 define		DEVICE	__device__
#endif

#if	!defined	CPU
#	 define		CPU
#endif

#if	!defined	is
#	 define		is	==
#endif

#if	!defined	isnot
#	 define		isnot	!=
#endif

#if	!defined	isnt
#	 define		isnt	isnot
#endif

#if	!defined	gt
#	 define		gt	>
#endif

#if	!defined	gte
#	 define		gte	>=
#endif

#if	!defined	lt
#	 define		lt	<
#endif

#if	!defined	lte
#	 define		lte	<=
#endif

#if	!defined	null
#	 define		null	NULL
#endif

#if	!defined	nullptr
#	 define		nullptr	null
#endif




#endif
