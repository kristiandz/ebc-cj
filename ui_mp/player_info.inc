#define PLAYERSTATS_WIDTH 		280

#ifdef PC
	#define PLAYERSTATS_X			((-(PLAYERSTATS_WIDTH - RIGHTITEM_OFFSET))-80)
	#define PLAYERSTATS_Y			70
	#define FRAME_BG_COLOR			1 1 1 1
#else
	#define PLAYERSTATS_X			(-(PLAYERSTATS_WIDTH - RIGHTITEM_OFFSET))
	#define PLAYERSTATS_Y			70
	#define FRAME_BG_COLOR			1 1 1 1
#endif	

#define ORIGIN_PLAYERSTATS 		PLAYERSTATS_X PLAYERSTATS_Y
	
#define LABEL_ITEM_SPACING		17.4
#define SUB_LABEL_INDENT		16
	
#define LABEL_START_X			12
#define LABEL_START_Y			LABEL_ITEM_SPACING
#define ORIGIN_LABEL			LABEL_START_X LABEL_START_Y

#define LABEL_TEXTCOLOR			0.85 0.8 0.8 1
#define LABEL_TITLECOLOR		0.85 0.8 0.8 1

#define ORIGIN_LABEL_ITEM( itemNumber ) \
		LABEL_START_X (LABEL_START_Y+(LABEL_ITEM_SPACING*(itemNumber-1))) 

#define ORIGIN_SUB_LABEL_ITEM( itemNumber ) \
		(LABEL_START_X+SUB_LABEL_INDENT) (LABEL_START_Y+(LABEL_ITEM_SPACING*(itemNumber-1))) 
		
#define ORIGIN_DIVIDER( itemNumber ) \
		0 (LABEL_START_Y+(LABEL_ITEM_SPACING/2)+(LABEL_ITEM_SPACING*(itemNumber-1))) 

#define PREPROC_LABEL( ptext, itemNumber ) \
itemDef { \
	text			ptext \
	rect			ORIGIN_LABEL_ITEM( itemNumber ) (PLAYERSTATS_WIDTH) LABEL_ITEM_SPACING RIGHTITEM_ALIGN VERTICAL_ALIGN_TOP \
	origin			ORIGIN_PLAYERSTATS \
	textfont		UI_FONT_NORMAL \ 
	textstyle 		ITEM_TEXTSTYLE_SHADOWED \
	textscale		TEXTSIZE_SMALL \
	textalign		ITEM_ALIGN_MIDDLE_LEFT \
	forecolor		LABEL_TITLECOLOR \
	visible			1 \
	decoration }
	
#define PREPROC_DIVIDER( itemNumber ) \
	PREPROC_SHADER_DRAW_ALIGNED( ORIGIN_DIVIDER( itemNumber ) (PLAYERSTATS_WIDTH) 1 RIGHTITEM_ALIGN VERTICAL_ALIGN_TOP, ORIGIN_PLAYERSTATS, "white", 1 0 0 0.5, 0, 0, 0 0 0 0 )

#define PREPROC_SUB_LABEL( ptext, itemNumber ) \
	PREPROC_SUB_LABEL_VIS( ptext, itemNumber, 1 )
	
#define PREPROC_SUB_LABEL_VIS( ptext, itemNumber, visArg ) \
itemDef { \
	text			ptext \
	rect			ORIGIN_SUB_LABEL_ITEM( itemNumber ) (PLAYERSTATS_WIDTH) LABEL_ITEM_SPACING RIGHTITEM_ALIGN VERTICAL_ALIGN_TOP \
	origin			ORIGIN_PLAYERSTATS \
	textfont		UI_FONT_NORMAL \ 
	textstyle 		ITEM_TEXTSTYLE_SHADOWED \
	textscale		TEXTSIZE_SMALL \
	textalign		ITEM_ALIGN_MIDDLE_LEFT \
	forecolor		LABEL_TEXTCOLOR \
	visible			visArg \
	decoration }
	
#define PREPROC_VALUE_TEXT( ptext, itemNumber, px_offset, pcolor ) \
		PREPROC_VALUE_TEXT_VIS( ptext, itemNumber, px_offset, pcolor, 1, ITEM_ALIGN_MIDDLE_RIGHT )

#define PREPROC_VALUE_TEXT_LEFT_ALIGNED( ptext, itemNumber, px_offset, pcolor ) \
		PREPROC_VALUE_TEXT_VIS( ptext, itemNumber, px_offset, pcolor, 1, ITEM_ALIGN_MIDDLE_LEFT )
		
#define PREPROC_VALUE_TEXT_VIS( ptext, itemNumber, px_offset, pcolor, visArg, alignment ) \
itemDef { \
	exp				text( ptext ); \
	type			ITEM_TYPE_TEXT \
	rect			ORIGIN_LABEL_ITEM( itemNumber ) (PLAYERSTATS_WIDTH) LABEL_ITEM_SPACING RIGHTITEM_ALIGN VERTICAL_ALIGN_TOP \
	textstyle 		ITEM_TEXTSTYLE_SHADOWED \
	origin			ORIGIN_PLAYERSTATS \
	textfont		UI_FONT_NORMAL \ 
	textalignx		px_offset \
	textscale		TEXTSIZE_SMALL \
	forecolor		pcolor \
	textalign		alignment \
	visible			visArg \
	decoration }
	
#define PREPROC_RANK_ICON( itemNumber, pshader, y_offset ) \
		PREPROC_RANK_ICON_VIS( itemNumber, pshader, y_offset, 1 )

#define PREPROC_RANK_ICON_VIS( itemNumber, pshader, y_offset, visArg ) \
	PREPROC_SHADER_DRAW_ALIGNED_VIS( (LABEL_START_X+PLAYERSTATS_WIDTH-80) (LABEL_START_Y+y_offset+(LABEL_ITEM_SPACING*(itemNumber-1))) 22 22 RIGHTITEM_ALIGN VERTICAL_ALIGN_TOP, ORIGIN_PLAYERSTATS, pshader, 1 1 1 1, 0, 0, 0 0 0 0, visArg )
	
	PREPROC_SHADER_DRAW_ALIGNED( -15 0 (PLAYERSTATS_WIDTH+35) 335 RIGHTITEM_ALIGN VERTICAL_ALIGN_TOP, ORIGIN_PLAYERSTATS, "cj_frame", 1 1 1 0.8, 0, 0, 0 0 0 1 )

#ifdef PC
	#define FRAME_HEIGHT	400
#else
	#define FRAME_HEIGHT	400
#endif

	PREPROC_DIVIDER( 9 )	
	PREPROC_LABEL( "Maps Finished", 10)	
	PREPROC_VALUE_TEXT( "In Work"/*stat(1420)*/, 10, -24, LABEL_TITLECOLOR )	
	
	PREPROC_DIVIDER( 11 )	
	
	PREPROC_LABEL( "Jumps", 12)	
	PREPROC_VALUE_TEXT( stat(2991), 12, -24, LABEL_TITLECOLOR )	
	
	PREPROC_DIVIDER( 13 )
	
	PREPROC_LABEL( "Saves", 14)
	PREPROC_VALUE_TEXT( stat(2992), 14, -24, LABEL_TITLECOLOR )
	
	PREPROC_LABEL( "Loads", 15)
	PREPROC_VALUE_TEXT( stat(2993), 15, -24, LABEL_TITLECOLOR )
	
	PREPROC_DIVIDER( 16 )	
	PREPROC_LABEL( "@MPUI_TIME_PLAYED_PRE", 17 )	
	PREPROC_VALUE_TEXT( secondsAsTime( stat( 2311 ) + stat( 2312 ) + stat( 2313 ) ), 17, -24, LABEL_TITLECOLOR )