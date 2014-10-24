t = PryTheme.create name: 'velina' do
  author name: 'Velina Veleva', email: 'vvveleva@gmail.com'
  description 'Precision colors for machines and people (based on solarized)'

  define_theme do
    class_ 'green'
    class_variable 'azure01'
    comment 'wet_asphalt02', [:italic]
    constant 'orange'
    error 'abdel_kerims_beard04'
    float 'robin_egg_blue01'
    global_variable 'azure01'
    inline_delimiter 'titian'
    instance_variable 'azure01'
    integer 'robin_egg_blue01'
    keyword 'crimson'
    method 'azure01'
    predefined_constant 'blue', [:bold]
    symbol 'robin_egg_blue01'

    regexp do
      self_ 'dark_goldenrod'
      char 'titian'
      content 'olive_drab'
      delimiter 'titian'
      modifier 'orange'
      escape 'titian'
    end

    shell do
      self_ 'titian'
      char 'titian'
      content 'robin_egg_blue01'
      delimiter 'titian'
      escape 'titian'
    end

    string do
      self_ 'titian'
      char 'green'
      content 'robin_egg_blue01'
      delimiter 'titian'
      escape 'robin_egg_blue02'
    end
  end
end

PryTheme::ThemeList.add_theme(t)
