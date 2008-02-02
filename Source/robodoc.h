#ifndef ROBODOC_ROBODOC_H
#define ROBODOC_ROBODOC_H

/*
Copyright (C) 1994-2007  Frans Slothouber, Jacco van Weert, Petteri Kettunen,
Bernd Koesling, Thomas Aglassinger, Anthon Pang, Stefan Kost, David Druffner,
Sasha Vasko, Kai Hofmann, Thierry Pierron, Friedrich Haase, and Gergely Budai.

This file is part of ROBODoc

ROBODoc is free software; you can redistribute it and/or modify
it under the terms of the GNU General Public License as published by
the Free Software Foundation; either version 3 of the License, or
(at your option) any later version.

This program is distributed in the hope that it will be useful,
but WITHOUT ANY WARRANTY; without even the implied warranty of
MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
GNU General Public License for more details.

You should have received a copy of the GNU General Public License
along with this program.  If not, see <http://www.gnu.org/licenses/>.

*/

#ifdef HAVE_CONFIG_H
#include "config.h"
#endif

#ifndef VERSION
#define VERSION "4.99.36"
#endif

#define COMMENT_ROBODOC \
    "Generated with ROBODoc Version " VERSION " (" __DATE__ ")\n"
#define COMMENT_COPYRIGHT\
    "ROBODoc (c) 1994-2007 by Frans Slothouber and many others.\n"

// Semaphore bits for actions
typedef struct actions_s
{
    // General options
    int                 do_nosort:1;
    int                 do_nodesc:1;
    int                 do_toc:1;
    int                 do_include_internal:1;
    int                 do_internal_only:1;
    int                 do_tell:1;
    int                 do_index:1;
    int                 do_nosource:1;
    int                 do_robo_head:1;
    int                 do_sections:1;
    int                 do_lockheader:1;
    int                 do_footless:1;
    int                 do_headless:1;
    int                 do_nopre:1;
    int                 do_ignore_case_when_linking:1;
    int                 do_nogenwith:1;
    int                 do_sectionnameonly:1;
    int                 do_verbal:1;
    int                 do_ms_errors:1;

    // Document modes
    int                 do_singledoc:1;
    int                 do_multidoc:1;
    int                 do_singlefile:1;
    int                 do_one_file_per_header:1;
    int                 do_no_subdirectories:1;

    // Latex options
    int                 do_altlatex:1;
    int                 do_latexparts:1;

    // Syntax coloring
    int                 do_quotes:1;
    int                 do_squotes:1;
    int                 do_line_comments:1;
    int                 do_block_comments:1;
    int                 do_keywords:1;
    int                 do_non_alpha:1;

} actions_t;

/* RB_Say modes */
#define SAY_DEBUG            (1<<0)
#define SAY_INFO             (1<<1)


/* Output Modes */

/****t* Generator/T_RB_DocType
 * FUNCTION
 *   Enumeration for the various output formats that are
 *   supported by ROBODoc.
 * NOTES
 *   These should be prefixed with RB_ 
 * SOURCE
 */

typedef enum
{
    TEST = 1,                   /* Special output mode for testing */
    ASCII,
    HTML,
    LATEX,
    RTF,
    TROFF,
    XMLDOCBOOK,
    /* SIZE_MODES, */
    /* Reserved for Future Use */
    /* ANSI, */
    /* GNUINFO, */
    /* XML, */
    UNKNOWN
} T_RB_DocType;

/*****/


#define USE( x ) ( x = x );

/* Evil macros !! */
#define skip_while(cond) { for (;*cur_char && (cond);cur_char++) ; }
#define find_eol   { for (;*cur_char && *cur_char!='\n';cur_char++) ; }
#define find_quote { for (;*cur_char && *cur_char!='\"';cur_char++) ; }

#ifndef FALSE
#define FALSE 0
#endif

#ifndef TRUE
#define TRUE  1
#endif

/* Prototypes */

actions_t           No_Actions(
    void );

#endif /* ROBODOC_ROBODOC_H */

