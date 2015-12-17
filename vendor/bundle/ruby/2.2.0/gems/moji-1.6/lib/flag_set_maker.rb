require "forwardable"


module FlagSetMaker
  
  
  class FlagSet
    
    def initialize(mod, names, zero= nil)
      @module= mod
      @flag_names= names.to_a()
      @zero_name= zero
      for i in 0...@flag_names.size
        mod.const_set(@flag_names[i], Flags.new(1 << i, self))
      end
      mod.const_set(@zero_name, Flags.new(0, self)) if @zero_name
    end
    
    def to_s(v)
      names= []
      @flag_names.each_with_index(){ |name, i| names.push(name) if v[i]==1 }
      if names.empty?()
        return (@zero_name.to_s() || "0")
      elsif names.size==1
        return names[0].to_s()
      else
        return "("+names.join("|")+")"
      end
    end
    
    def inspect(v= nil)
      return v ? format("%p::%s", @module, to_s(v)) : super()
    end
    
    def validate(v)
      return v&((1 << @flag_names.size)-1)
    end
    
  end
  
  
  class Flags
    
    extend(Forwardable)
    
    def initialize(v, fs)
      @value= fs.validate(v)
      @flag_set= fs
    end
    
    def to_i()
      return @value
    end
    
    def to_s()
      return @flag_set.to_s(@value)
    end
    
    def inspect()
      return @flag_set.inspect(@value)
    end
    
    def ==(rhs)
      return rhs.is_a?(Flags) && @flag_set==rhs.flag_set && @value==rhs.to_i()
    end
    
    alias :eql? :==
    
    def_delegators(:to_i, :hash)
    
    def &(rhs)
      return new_flag(@value&rhs.to_i())
    end
    
    def |(rhs)
      return new_flag(@value|rhs.to_i())
    end
    
    def ~()
      return new_flag(~@value)
    end
    
    def include?(flags)
      return (@value&flags.to_i())==flags.to_i()
    end
    
    def empty?()
      return @value!=0
    end
    
  protected
    
    attr_reader(:flag_set)
    
  private
    
    def new_flag(v)
      return Flags.new(v, @flag_set)
    end
    
  end
  
  
  def make_flag_set(*args)
    FlagSet.new(self, *args)
  end
  
end


if __FILE__==$0
  
  class Hoge
    
    extend(FlagSetMaker)
    
    make_flag_set([:FOO, :BAR, :HOGE], :NONE)
    
  end
  
end
