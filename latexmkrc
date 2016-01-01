#!/usr/bin/env perl

# http://pushl.net/blog/11/
# Note that each rc file may unset $auto_rc_use to
# prevent lower-level rc files from being read.
# So test on $auto_rc_use in each case.
if ( $auto_rc_use ) {
    # System rc file:
    read_first_rc_file_in_list( @rc_system_files );
}
if ( $auto_rc_use ) {
    # User rc file:
    read_first_rc_file_in_list( "$HOME/.latexmkrc" );
}
if ( $auto_rc_use ) { 
    # Rc file in current directory:
    read_first_rc_file_in_list( "latexmkrc", ".latexmkrc" );
}

# XeLaTeX / LuaLaTeX
# ----------------------------------------------------------------------------
# Since XeLaTeX only produces PDF files, it is a replacement for pdfLaTeX.
# -interaction=nonstopmode -synctex=1: Don't stop for errors, use SyncTeX
$pdflatex   = 'xelatex -interaction=nonstopmode --shell-escape -synctex=1 %O %S';
#$pdflatex   = 'lualatex -shell-escape -8bit';

# PDF Mode
# ---------------------------------------------------------------------------- 
# 0 ... do NOT generate a PDF version of the document.
# 1 ... generate a PDF version of the document using pdfLaTeX
# 2 ... generate a PDF version of the document from the ps file, by using the command specified by the $ps2pdf variable.
# 3 ... generate a PDF version of the document from the dvi file, by using the command specified by the $dvipdf variable.
$pdf_mode   = 1; $postscript_mode = $dvi_mode = 0;
$max_repeat = 5;


# Bib(La)TeX settings
# ----------------------------------------------------------------------------
# 0 ... never use BibTeX.
# 1 ... only use BibTeX if the bib files exist.
# 2 ... run BibTeX whenever it appears necessary to update the bbl files, without testing for the existence of the bib files.
$bibtex_use          = 2;

# User Biber instead of BibTeX
$biber               = 'biber %O -l zh__stroke -u -U --output_safechars %B';
#$biber_silent_switch = '--onlylog';

# MakeIndex & MakeGlossaries
# ----------------------------------------------------------------------------
# tex.stackexchange.com/questions/58963/latexmk-with-makeglossaries-and-auxdir-and-outdir

#add_cus_dep('idx', 'ind', 0, 'run_makeindex');
#add_cus_dep('glo', 'gls', 0, 'run_makeglossaries');
#add_cus_dep('acn', 'acr', 0, 'run_makeglossaries');
#show_cus_dep();

#sub run_makeindex{
#    my ($base_name, $path) = fileparse( $_[0] );
#    pushd $path;
#    my $return = system("zhmakeindex -z bihua $base_name");
#    popd;
#    return $return;
#}
#push @generated_exts, 'idx', 'ind', 'ilg';

#sub run_makeglossaries {
#   my ($base_name, $path) = fileparse( $_[0] );
#   pushd $path;
#   my $return = system "makeglossaries $base_name";
#   popd;
#   return $return;
#}
#push @generated_exts, 'glo', 'gls', 'glg';
#push @generated_exts, 'acn', 'acr', 'alg';


# Default PDF viewer
# ----------------------------------------------------------------------------
$pdf_previewer = 'evince %O %S'; # Mac OS X: 'open -ga /Applications/Skim.app'

# Prevent Latexmk from removing PDF after typeset.
$pvc_view_file_via_temporary = 0;

# https://github.com/leachim/dotfiles/blob/master/desktop/.latexmkrc
# Use if -pvc ($preview_continuous_mode) is NOT active, so that terminal can launch previewer.  Otherwise, a conflict exists.
#$preview_mode = 1;
# -pvc equivalent.  If nonzero, run a previewer to view the document and keep the DVI file up to date.
#$preview_continuous_mode = 1;


# Clean @generated_exts, log files and ...
# ----------------------------------------------------------------------------
# Default: aux , bbl , idx , ind , lof , lot , out , toc , $fdb_ext , ... 
push @generated_exts, 'bcf', 'blg', 'ist', 'ltjruby'; 

# https://github.com/Studio513/swjtuThesis/raw/master/.gitignore
# Extra file extensions to clean when latexmk -c or latexmk -C is used
$clean_ext = '%R.run.xml %R.xdv'

