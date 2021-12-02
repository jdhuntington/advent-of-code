#!/usr/bin/env ruby


REQUIRED = %w{ byr iyr eyr hgt hcl ecl pid }.sort
EYE_COLORS=%w{amb blu brn gry grn hzl oth}

class Passport

  def data= keyvals
    @data = {}
    keyvals.each do |kv|
      @data[kv[0]] = kv[1]
    end
  end

  def keys
    @data.keys.sort
  end

  def has_required_fields?
    keys & REQUIRED == REQUIRED
  end

  def valid_birth_year?
    byr.to_i >= 1920 && byr.to_i <= 2002
  end

  def valid_issue_year?
    iyr.to_i >= 2010 && iyr.to_i <= 2020
  end
  
  def valid_expiration_year?
    eyr.to_i >= 2020 && eyr.to_i <= 2030
  end

  def valid_height?
    if hgt =~ /\d+cm/
      return hgt.to_i >= 150 && hgt.to_i <= 193
    elsif hgt =~ /\d+in/
      return hgt.to_i >= 59 && hgt.to_i <= 76
    else
      false
    end
  end

  def valid_hair_color?
    hcl =~ /^#[0-9a-f]{6}$/i
  end

  def valid_eye_color?
    EYE_COLORS.index ecl
  end

  def valid_passport_id?
    pid =~ /^\d{9}$/
  end

  def valid?
    return false unless has_required_fields?
    return false unless valid_birth_year?
    return false unless valid_issue_year?
    return false unless valid_expiration_year?
    return false unless valid_height?
    return false unless valid_hair_color?
    return false unless valid_eye_color?
    return false unless valid_passport_id?
    true
  end

  def method_missing sym
    @data[sym.to_s]
  end

  def self.from_text t
    x = new
    x.data = t.split.map { |kv| kv.split ':' }
    x
  end
end

passports = ARGF.read.split("\n\n").map { |x| Passport.from_text x }
puts "Valid: #{passports.select(&:valid?).length}"
