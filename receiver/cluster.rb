
EXAMPLES = [
    {
        name: 'Intenção de compra em Notebooks Asus',
        tags: [
            ['notebook', 'asus']
        ]
    },
    {
        name: 'Intenção de compra em Notebooks Samsung',
        tags: [
            ['notebook', 'samsung']
        ]
    },
    {
        name: 'Intenção de compra em Notebooks Lenovo',
        tags: [
            ['notebook', 'lenovo']
        ]
    }
]

class Cluster

  def self.load
    EXAMPLES.map { |attributes| new(attributes) }
  end

  def initialize(id:, name:, tags: [])
    @regex = build_regex(tags)
    @name = name
    @id = id
  end

  def match(url)
    score = url.scan(@regex).size
    { score: score, id: @id, name: @name }
  end

  private

  def build_regex(tags)
    value = tags.map { |term| term.one? ? term : (term.map { |t| "(?=.*#{t})" }.join + '.*')  }.join('|')
    Regexp.new(value, 'gmi')
  end

end
