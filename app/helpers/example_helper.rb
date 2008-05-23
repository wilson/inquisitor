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
end
