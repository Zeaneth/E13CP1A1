class Sale < ApplicationRecord
validates :cod, uniqueness: true
validates :detail, presence: true
validates_inclusion_of :category, in: %w( uno dos tres cuatro ), message: "%{value} no es una categoría válida"
validates_numericality_of :value, :greater_than_or_equal_to => 0
validates_numericality_of :discount, :only_integer => true, :less_than_or_equal_to => 40

end
