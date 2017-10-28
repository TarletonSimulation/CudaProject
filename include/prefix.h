#if	!defined( __tsx_prefix__ )
#	 define	  __tsx_prefix__

#include <stdio.h>
#include <stdlib.h>
#include <stdarg.h>
#include <unistd.h>
#include <math.h>
#include <string.h>

#include <limits.h>
#include <float.h>
#include <stdint.h>

#include <sys/wait.h>
#include <sys/socket.h>
#include <sys/time.h>
#include <time.h>


// cpp stuff //
#include <iostream>
#include <iomanip>
#include <string>
#include <list>

#if	!defined	CPU
#	 define		CPU
#endif

#if	!defined	GPU
#	 define		GPU	__global__
#endif

#if	!defined	DEVICE
#	 define		DEVICE	__device__
#endif


#if	!defined	SHARED
#	 define		SHARED	__shared__
#endif

#if	!defined	CONST
#	 define		CONST	__constant__
#endif

#if	!defined	is
#	 define		is	==
#endif

#if	!defined	isnot
#	 define		isnot	!=
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

#if	!defined	tsx_max
#	 define		tsx_max(a,b)	( ( (a)>(b) )?(a):(b) )
#endif

#if	!defined	tsx_min
#	 define		tsx_min(a,b)	( ( ( (a)<(b) )?(a):(b) ) )
#endif


namespace tsx{

	typedef	unsigned 	int	uint;
	typedef	unsigned 	char	uchar;
	typedef	unsigned 	short	ushort;
	typedef	unsigned 	long	ulong;
	typedef	unsigned long	long	ullong;

}


#endif
