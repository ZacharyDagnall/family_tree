class Marriage < ApplicationRecord
    # A "Filial" is a nice and concise word for a Parent-Child Relationship
    belongs_to :husband, class_name: "Person", foreign_key: "husband_id"
    belongs_to :wife, class_name: "Person", foreign_key: "wife_id"

    def husband_name=(name)
        self.husband = Person.find_or_create_by_no_case(name)
    end

    def husband_name
        self.husband ? self.husband.name : nil
    end

    def wife_name=(name)
        self.wife = Person.find_or_create_by_no_case(name)
    end

    def wife_name
        self.wife ? self.wife.name : nil
    end

end
