CREATE MIGRATION m135tbqij6cavoeh7jxlodkwzapbfhrxct5b2rncmrwwa2cloklq5a
    ONTO initial
{
  CREATE ABSTRACT TYPE default::BaseObject {
      CREATE REQUIRED PROPERTY created_at: std::datetime {
          SET default := (std::datetime_current());
      };
      CREATE REQUIRED PROPERTY updated_at: std::datetime {
          SET default := (std::datetime_current());
      };
  };
  CREATE TYPE default::Injury EXTENDING default::BaseObject {
      CREATE REQUIRED PROPERTY name: std::str;
  };
  CREATE TYPE default::InjuryLocation EXTENDING default::BaseObject {
      CREATE MULTI LINK injuries: default::Injury;
      CREATE REQUIRED PROPERTY name: std::str;
  };
  CREATE TYPE default::MedicalDevice EXTENDING default::BaseObject {
      CREATE REQUIRED PROPERTY name: std::str;
  };
  CREATE TYPE default::Symptom EXTENDING default::BaseObject {
      CREATE MULTI LINK indicative_of: default::Injury;
      CREATE REQUIRED PROPERTY description: std::str;
  };
  CREATE TYPE default::Treatment EXTENDING default::BaseObject {
      CREATE MULTI LINK used_for: default::Injury;
      CREATE MULTI LINK requires_devices: default::MedicalDevice;
      CREATE REQUIRED PROPERTY name: std::str;
  };
  ALTER TYPE default::Injury {
      CREATE MULTI LINK symptoms: default::Symptom;
      CREATE MULTI LINK treatments: default::Treatment;
  };
  ALTER TYPE default::MedicalDevice {
      CREATE MULTI LINK required_for: default::Treatment;
  };
};
