class Person < ApplicationRecord
    has_many :filials
    has_many :parent_relationships, class_name: "Filial", foreign_key: :child_id, dependent: :destroy
    has_many :parents, through: :parent_relationships, source: :parent
    has_many :child_relationships, class_name: "Filial", foreign_key: :parent_id, dependent: :destroy
    has_many :children, through: :child_relationships, source: :child

    has_one :marriage
    has_one :wife_relationship, class_name: "Marriage", foreign_key: :husband_id, dependent: :destroy
    has_one :wife, through: :wife_relationship, source: :wife
    has_one :husband_relationship, class_name: "Marriage", foreign_key: :wife_id, dependent: :destroy
    has_one :husband, through: :husband_relationship, source: :husband

    def self.find_or_create_by_no_case(name_arg)
        person = self.find_by("name LIKE ?", name_arg)
        return person unless !person
        self.create(name: name_arg)
    end

    #shouldnt this be free with macros?
    def marriage
        return nil if (!self.wife_relationship && !self.husband_relationship)
        self.wife_relationship ? self.wife_relationship : self.husband_relationship
    end

    def spouse
        return nil if self.single?
        self.wife ? self.wife : self.husband
    end

    #shouldnt this already be available through macros?
    def filials
        Filial.select{|filial| self.parent_relationships.include?(filial) || self.child_relationships.include?(filial)}
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

    def siblings
        Person.all.select{|person| !(person.parents & self.parents).empty? && person!=self}
    end

    def has_siblings?
        !self.siblings.empty?
    end

    def grandparents
        self.parents.flat_map{|parent| parent.parents}
    end

    def has_grandparents?
        !self.grandparents.empty?
    end

    def cousins
        Person.all.select{|person| !(person.grandparents & self.grandparents).empty? && person!=self && !self.siblings.include?(person)}
    end

    def has_cousins?
        !self.cousins.empty?
    end

    def auntcles
        blood_auntcles = Person.all.select{|person| !(person.siblings & self.parents).empty?}
        marriage_auntcles = blood_auntcles.select{|ba| ba.married?}.map(&:spouse)
        blood_auntcles+marriage_auntcles
    end

    def has_auntcles?
        !self.auntcles.empty?
    end
end
