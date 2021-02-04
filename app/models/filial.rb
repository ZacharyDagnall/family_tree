class Filial < ApplicationRecord
    # A "Filial" (i.e. a "filial relationship") is a nice and concise word for a Parent-Child Relationship
    belongs_to :child, class_name: "Person", foreign_key: "child_id"
    belongs_to :parent, class_name: "Person", foreign_key: "parent_id"
    
    def parent_name=(name)
        self.parent = Person.find_or_create_by_no_case(name)
    end

    def parent_name
        self.parent ? self.parent.name : nil
    end

    def child_name=(name)
        self.child = Person.find_or_create_by_no_case(name)
    end

    def child_name
        self.child ? self.child.name : nil
    end

end
