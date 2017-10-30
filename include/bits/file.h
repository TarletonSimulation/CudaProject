#if	!defined( __tsx__file_bits__ )
#	 define	  __tsx__file_bits__

namespace	tsx{

	const	int	FFLAG_READONLY		= 00000;
	const	int	FFLAG_WRITEONLY		= 00001;
	const	int	FFLAG_READWRITE		= 00002;

	
	typedef	enum{
		FERR_NOERROR	= 0,	// no errors // duh //
		FERR_ACCESS,
		FERR_QUOTA,
		FERR_EXIST,
		FERR_FAULT,
		FERR_OVERFLOW,
		FERR_INVALID,
		FERR_INTERRUPT,
		FERR_DIRECTORY,
		FERR_LOOP,
		FERR_MAX_DESC,
		FERR_NODEVICE,
		FERR_OPNOTSUP,
		FERR_PERMISSION,
		FERR_ROFS,
		FERR_TEXTBUSY,
		FERR_BADDESC,
		FERR_NOTDIR,
		FERR_WOULDBLOCK,
		FERR_NOXIO,
		FERR_NOMEMORY,
		FERR_NOSPACE
	}FileError_t;
	
}
#endif	// end __tsx__file_bits__ //
