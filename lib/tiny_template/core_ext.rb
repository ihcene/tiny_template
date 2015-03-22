class String
  def parse(context = nil)
    unless context
      RubyVM::DebugInspector.open do |inspector|
        context = eval('self', inspector.frame_binding(2))
      end
    end

    TinyTemplate(self, context)
  end

  alias_method :~, :parse
end