# frozen_string_literal: true

# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)
columns = [:name]
category = [
  ['Жанр Боевики'],
  ['Жанр Военные'],
  ['Жанр Детективы'],
  ['Жанр Детская проза'],
  ['Жанр Домашняя'],
  ['Жанр Драма'],
  ['Жанр Историческая проза'],
  ['Жанр Классика'],
  ['Жанр Медицина'],
  ['Жанр Научная фантастика'],
  ['Жанр Политика'],
  ['Жанр Приключение'],
  ['Жанр Психология'],
  ['Жанр Романы'],
  ['Жанр Сказки'],
  ['Жанр Современная проза'],
  ['Жанр Триллеры'],
  ['Жанр Ужасы и мистика'],
  ['Жанр Фэнтези'],
  ['Жанр Эротика'],
  ['Жанр Юмористическая проза']
]
Category.import columns, category
