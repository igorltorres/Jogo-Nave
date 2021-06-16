require 'gosu'

class Jogador 
  attr_reader :placar 
  def initialize (janela)
    @janela = janela
    @imagem_nave = Gosu::Image.new(@janela,"Nave.png", true)
    @imagem_tiro = Gosu::Image.new(@janela,"tiro.png", true)
	@imagem_explosion1 = Gosu::Image.new(@janela,"explosion.png", true)
	@imagem_explosion2 = Gosu::Image.new(@janela,"explosion.png", true)
	@imagem_inimigo1 = Gosu::Image.new(@janela,"Inimigo.png", true)
	@imagem_inimigo2 = Gosu::Image.new(@janela,"Inimigo.png", true)
	@placar = 0 
    @angulo = 0.0
	@x_nave =320  
    @y_nave =450
	
	@x_tiro = @x_nave
	@y_tiro = @y_nave
	@gatilho=0
	
	@x_inimigo1 = 170 
	@y_inimigo1 = 100 
	@x_inimigo2 = 450 
	@y_inimigo2 = 0
	@vel_in = 1
	
	
	@x_explosion1=0
	@y_explosion1=0
	@esc1=0
	@x_explosion2=100
	@y_explosion2=100
	@esc2=0
	
	
  end 

  def draw
    @imagem_nave.draw_rot(@x_nave, @y_nave, 6, @angulo)
	@imagem_tiro.draw_rot(@x_tiro, @y_tiro, 3, @angulo)
	@imagem_inimigo1.draw_rot(@x_inimigo1,@y_inimigo1,4,@angulo)
	@imagem_inimigo2.draw_rot(@x_inimigo2,@y_inimigo2,4,@angulo)
	
	@imagem_explosion1.draw_rot(@x_explosion1,@y_explosion1,@esc1,@angulo)
	@imagem_explosion2.draw_rot(@x_explosion2,@y_explosion2,@esc2,@angulo)
	
	
	
  end
  
  
  def direita
    @x_nave += 5.0
	
	if(@x_nave==620)then
	@x_nave=615
	
	end
  
  end 
    
  def esquerda
    @x_nave -= 5.0
	
	if(@x_nave==20)then
	 @x_nave=25 
    end  
  end
 
  
  def atirar
   
   @gatilho = 1
  
  end
  
  def atirando
  @x_tiro=@x_nave
  if (@gatilho==1)then
     @y_tiro -=30
	 
	 if(@y_tiro<0)then
	 @y_tiro = @y_nave
	 @x_tiro=@x_nave
	 @gatilho=0
	 end
  end
  
 end
 
 def navin
    @esc1=0
	@esc2=0
	@vel_in +=0.00002
	@y_inimigo1 +=2.5 * @vel_in
    @y_inimigo2 +=2.5 * @vel_in
	if(@y_inimigo1>480)then
	 @y_inimigo1=0
	 @x_inimigo1 +=100
     if(@x_inimigo1>350)then
	    @x_inimigo1=50
	 end
	 end
	 if (@y_inimigo2>480)then
	  @y_inimigo2=0
	  @x_inimigo2 -=100
	  if(@x_inimigo2<340)then
	   @x_inimigo2 = 600
	 end
	 end
 end 
def explosion
 
 if Gosu::distance(@x_tiro, @y_tiro, @x_inimigo1, @y_inimigo1) < 20
    @x_explosion1=@x_inimigo1
	@y_explosion1=@y_inimigo1
	@y_inimigo1=0
	@x_inimigo1 +=100
    if(@x_inimigo1>350)then
	    @x_inimigo1=50
	 end
	@esc1=5
	@placar +=1
 end
 if Gosu::distance(@x_tiro, @y_tiro, @x_inimigo2, @y_inimigo2) < 20
    @x_explosion2=@x_inimigo2
	@y_explosion2=@y_inimigo2
	@y_inimigo2=0
	@x_inimigo2 -=100
	if(@x_inimigo2<340)then
	   @x_inimigo2 = 600
	 end
	@esc2=5
	@placar +=1
 
 end
 end
  
  end
