class CompanyProfile < PdfReport

  # pdf = CompanyProfile.new
  # pdf.consumer = { consumer: {id: '000095', name: 'My Company'}, user: {id: '000533885', name: 'P.G. van Oosten'} }
  # # pdf.xml = '<...>'
  # pdf.generate(file: '/tmp/test.pdf')
  def generate(file: '/tmp/test.pdf')
    header_and_footer('KREDIETINFORMATIERAPPORT') do
      text 'this is some stupid text to get at least a single page'
    end
    save_as(file) if file
  end

end
