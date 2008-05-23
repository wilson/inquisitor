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
      local = locals[i].inspect
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
    lines = File.readlines file

    first.upto(last) do |i|
      mark = i == line ? "*" : " "
      number = "%5d%s  " % [i, mark]
      yield number + lines[i-1]
    end
  end

  def link_to_frame(name, frame, index)
    link_to name, "", :class => "frame_#{frame_type_of(frame)}",
            :onclick => "return toggle_frame(#{index})"
  end
end
