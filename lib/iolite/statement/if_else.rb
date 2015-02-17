module Iolite module Statement
	def if_else cond, then_, else_
		Lambda::Block.new { |*args|
			if Functinal.invoke(cond, *args)
				Functinal.invoke(then_, *args)
			else
				Functinal.invoke(else_, *args)
			end
		}
	end
end end
