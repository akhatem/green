WickedPdf.config ||= {}
WickedPdf.config.merge!({
  exe_path: '/usr/local/bin/wkhtmltopdf',
  layout: "pdf",
  orientation: "Landscape",
  page_size: "A4",
  no_pdf_compression: true
})