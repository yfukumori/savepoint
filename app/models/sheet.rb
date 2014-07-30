class Sheet < ActiveRecord::Base
    belongs_to :user
	belongs_to :topic

	def str_mod
		(str-10)/2
	end

	def dex_mod
		(dex-10)/2
	end

	def con_mod
		(con-10)/2
	end

	def int_mod
		(int-10)/2
	end

	def wis_mod
		(wis-10)/2
	end

	def cha_mod
		(cha-10)/2
	end

	def armor_class
		armor_bonus + shield_bonus + dex_mod + nat_armor + 10
	end

	def touch_ac
		shield_bonus + dex_mod + 10
	end

	def flat_foot
		armor_bonus + shield_bonus + nat_armor + 10
	end

	def fort
		fort_save + con_mod
	end

	def will
		will_save + wis_mod
	end

	def ref
		ref_save + dex_mod
	end

	def cmb
		base_attack_bonus + str_mod
	end

	def cmd
		base_attack_bonus + str_mod + dex_mod + 10
	end

	def size_word
		if character_size == 1
			"Large"
		elsif character_size == 0
			"Medium"
		elsif character_size == -1
			"Small"
		end
	end
end
