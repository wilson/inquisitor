module ExampleHelper
  def frame_type_of(frame)
    case frame.file.to_s
    when /app\/(controllers|helpers|models)/
      'app'
    when /app\/views/
      'view'
    when /kernel/
      'kernel'
    when /(gems|vendor)/
      'framework'
    when /lib\/(rubinius|rbx)?/
      'stdlib'
    when /\(eval\)/
      'eval'
    else
      'unknown'
    end
  end

  def each_local(ctx)
    names = ctx.method.local_names
    locals = ctx.locals

    i, num = 0, locals.size
    while i < num
      name = names[i].to_s
      local = locals[i].pretty_inspect rescue locals[i].inspect
      i += 1

      next if name[0] == ?@
      yield name, local
    end
  end

  def each_context(ctx)
    i = 0
    while ctx
      unless ctx.method
        ctx = ctx.sender
        next
      end

      yield ctx, i+=1
      ctx = ctx.sender
    end
  end

  def source_for(frame)
    file = frame.file.to_s
    return "" unless File.exist? file

    frame.method.line_from_ip(frame.ip)
    line = frame.method.line_from_ip frame.ip

    first = line > 6 ? line - 6 : 1
    last = line + 6
    source = File.read file
    lines = syntax(source)

    first.upto(last) do |i|
      mark = i == line ? " =>" : "   "
      number = "%5d%s  " % [i, mark]
      next unless current = lines[i-1]
      yield number + current
    end
  end

  def link_to_frame(name, frame, index)
    link_to name, "", :class => "frame_#{frame_type_of(frame)}",
            :onclick => "return toggle_frame(#{index})"
  end

  def convert_syntax(text, lang = :ruby)
    @converters ||= {}
    @converters[lang.to_sym] ||= Syntax::Convertors::HTML.for_syntax(lang.to_s)
    html = CGI::unescapeHTML(text)
    html = @converters[lang.to_sym].convert(html, false).to_a
    html.delete_at(0) if html.size > 0 and html[0].chomp.empty?

    html.collect { |ln| "<li>#{ln.rstrip}</li>" }
  end

  def syntax(html, language = :ruby)
    begin
      html.gsub!(/<!--(.*?)-->[\n]?/m, "")
      lines = convert_syntax(html, language)
      return lines
    rescue => e
      logger.warn "Exception in syntax() helper: #{e}:\n #{e.awesome_backtrace}"
      logger.warn "syntax() was passed language: #{language}"
      logger.warn "syntax() was passed html: #{html}"
      return []
    end
  end
end
