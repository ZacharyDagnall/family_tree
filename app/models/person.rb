class Person < ApplicationRecord
    has_many :filials
    has_one :marriage

    def self.find_or_create_by_no_case(name_arg)
        person = self.find_by("name LIKE ?", name_arg)
        return person unless !person
        self.create(name: name_arg)
    end

    def marriage
        Marriage.find{|marriage| marriage.husband == self || marriage.wife == self}
    end

    def spouse #probably a way to tighten this up
        if self.single?
            return nil
        elsif self.marriage.husband == self
            return self.marriage.wife
        else 
            return self.marriage.husband 
        end
    end

    def filials
        Filial.select{|filial| filial.parent == self || filial.child == self}
    end

    def parents
        self.filials.select{|filial| filial.child == self}.map(&:parent)
    end

    def children
        self.filials.select{|filial| filial.parent == self}.map(&:child)
    end

    def single?
        !self.married?
    end

    def married?
        !!self.marriage
    end

    def orphan?
       self.parents.empty?
    end

    def has_children?
        !self.children.empty?
    end

    def age
        self.dob ? Date.today.year - self.dob.year : 0
    end

    def age=(num)   #updates a person's dob if their age is inputted
        self.dob = Date.today - num.to_i.years
    end
end
