#define QDEL_NULL(x) if(x) { qdel(x) ; x = null }

#define QDEL_CUT(x)				\
	if(x) {						\
		for(var/datum/D in x)	\
			qdel(D);			\
		x.Cut();				\
	}							\

