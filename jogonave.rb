require 'gosu'
require_relative 'jogador'


class Jogonave < Gosu::Window
  @@formato = [3, 1.0, 1.0, 0xffffffff]

  def initialize 
    super(640,480,false)
    self.caption = "JOGO DA NAVE"
    @imagem_inicio = Gosu::Image.new(self, "capa.png", true)
    @imagem_fundo = Gosu::Image.new(self, "Space.png", true)
    @jogador = Jogador.new(self) 
    @fonte = Gosu::Font.new(self, Gosu::default_font_name, 20)
    @tempo = 0.0
    @estado = "INICIO"
	t=0
  end 

  def draw
    
    if    @estado == "INICIO"  then draw_inicio
    elsif @estado == "JOGANDO" then draw_jogando
    else                            draw_fim     end 
  end
  
  private
  def draw_inicio
    @imagem_inicio.draw(0,0,0)
    msg = "APERTE A [BARRA DE ESPAÇO] PARA INICIAR O JOGO"
    x = self.width / 2 - @fonte.text_width(msg,1) / 2
    @fonte.draw(msg, x, self.height/2, *@@formato)
  end

  def draw_jogando
    @imagem_fundo.draw(0,0,1)
    @jogador.draw() 
    @fonte.draw("Naves Destruidas : #{@jogador.placar}", 10, 10, *@@formato)
    @fonte.draw("Tempo: #{@tempo.to_i}s",     10, 30, *@@formato)
  end

  def draw_fim
    msg = "FIM DE JOGO, VOCE FEZ #{@jogador.placar} PONTOS"
    x = self.width / 2 - @fonte.text_width(msg,1) / 2
    @fonte.draw(msg, x, self.height/2, *@@formato)
  end

  public
  def update
    if    @estado == "INICIO" then update_inicio      
    elsif @estado =="JOGANDO" then update_jogando
    #elsif (@estado == "FIM") then
    end 
  end

  private 
  def update_inicio
    @estado = "JOGANDO" if button_down?(Gosu::Button::KbSpace)
  end

  def update_jogando
    @jogador.direita  if button_down?(Gosu::Button::KbRight)  
    @jogador.esquerda if button_down?(Gosu::Button::KbLeft) 
    @jogador.atirar if button_down?(Gosu::Button::KbUp)
    @jogador.atirando
	
	
	@jogador.navin
    @jogador.explosion
    
    @tempo += 1.0/60.0
    @estado = "FIM" if @tempo.to_i >= 30
	if button_down?(Gosu::Button::KbC)then
	@estado = "INICIO"
	end
	
  end    
end

