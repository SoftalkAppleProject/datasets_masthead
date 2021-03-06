; IDL program to convert just a single page of the Softalk OCR's
; to both a PDF and a JPEG.
;
compile_opt idl2

file = FINDFILE('*.pdf')
dirOut = "Masthead/"
for i=0,n_elements(file)-1 do begin
  ; The masthead page number changes as the magazine progresses
  page = '3'
  if (i ge 17) then page = '4'
  if (i ge 37) then page = '6'
  cmdCommon = " -dBATCH -dNOPAUSE -dFirstPage=" + page + " -dLastPage=" + page + $
    " -sOutputFile=" + dirOut
  ; JPEG
  fout = ((file[i]).Replace('Softalk_', '')).Replace('_OCR.pdf', '_masthead.jpg')
  cmd = "gs -sDEVICE=jpeg -r300 " + cmdCommon + fout + " " + file[i]
  print, cmd
  spawn, cmd, result
  ; PDF
  fout = ((file[i]).Replace('Softalk_', '')).Replace('_OCR.pdf', '_masthead.pdf')
  cmd = "gs -sDEVICE=pdfwrite " + cmdCommon + fout + " " + file[i]
  print, cmd
  spawn, cmd, result
endfor

end

