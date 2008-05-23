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

  def link_to_frame(name, frame, index)
    link_to name, "", :class => frame_type_of(frame),
            :onclick => "return toggle_frame(#{index})"
  end
end
