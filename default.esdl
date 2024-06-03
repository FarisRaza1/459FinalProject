module default {
    abstract type BaseObject {
        required property created_at -> datetime {
            default := datetime_current();
        }
        required property updated_at -> datetime {
            default := datetime_current();
        }
    }

    type Injury extending BaseObject {
        required property name -> str;
        property description -> str;
        # Embedding to represent textual information in vector form
        required property embedding -> array<float32>;
        multi link treatments -> Treatment;
        multi link symptoms -> Symptom;
    }

    type Treatment extending BaseObject {
        property name -> str;
        property description -> str;
        # Embedding for treatments
        required property embedding -> array<float32>;
        multi link used_for -> Injury;
        multi link requires_devices -> MedicalDevice;
    }

    type MedicalDevice extending BaseObject {
        property name -> str;
        # Optionally include a description if relevant
        property description -> str;
        multi link required_for -> Treatment;
    }

    type Symptom extending BaseObject {
        property description -> str;
        multi link indicative_of -> Injury;
    }
}
