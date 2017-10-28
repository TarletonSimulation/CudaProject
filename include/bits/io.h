#if	!defined( __tsx__file_bits__ )
#	 define	  __tsx__file_bits__

#include <tsx/prefix.h>

namespace	tsx{

// File Stream Type //
const	int	FS_IN		=	0x0001;
const	int	FS_OUT		=	0x0002;
const	int	FS_IN_OUT	=	0x0003;
const	int	FS_OUT_ONLY	=	0x0004;


const	int	FT_REGULAR	=	0x0010;
const	int	FT_SYMLNK	=	0x0020;
const	int	FT_BLCKDEV	=	0x0040;
const	int	FT_CHARDEV	=	0x0080;
const	int	FT_FIFO		=	0x00a0;
const	int	FT_DIR		=	0x00f0;


}

#endif
