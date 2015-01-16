    def external_transfer(user_id,
                          amount_micros,
                          iso_currency_code,
                          external_ref_id,
                          external_ref_type)

def external_transfer(options)

# Named arguments are awesome, but...

NoMethodError: undefined method `original_payment2' for nil:NilClass
RuntimeError: Called id for nil, which would mistakenly be 4 -- if you really wanted the id of nil, use object_id
NoMethodError: undefined method `round' for "431.45":String

# We want to fail early

def external_transfer(options)
      [
        :user_id,
        :amount_micros,
        :external_ref_id,
        :external_ref_type
      ].each do |option|
        raise ArgumentError if options[option].blank?
      end

...
end

---

      validate_mandatory_options(options, [
        :user_id, :account_type, :external_ref_id, :external_ref_type
      ])

    def validate_mandatory_options(options, mandatory_options)
      mandatory_options.each do |option|
        raise ArgumentError, "Argument #{option} is mandatory" if options[option].blank?
      end
    end

---

      unless options[:sender].is_a?(User)
        raise ArgumentError, "sender is #{options[:sender].class.name}, not a User"
      end
      unless options[:payment].is_a?(Payment2)
        raise ArgumentError, "payment is #{options[:payment].class.name}, not a Payment2"
      end

---

      validate_mandatory_options(options, [
        :gift_credit,
        :payment,
        :sender,
        :amount_micros,
        :iso_currency_code,
        :ip
      ])
      validate_amount(options[:amount_micros], options[:iso_currency_code])

      unless options[:sender].is_a?(User)
        raise ArgumentError, "sender is #{options[:sender].class.name}, not a User"
      end
      unless options[:payment].is_a?(Payment2)
        raise ArgumentError, "payment is #{options[:payment].class.name}, not a Payment2"
      end

# This was getting out of hand

      validate_arg(options) do |o|
        o.validate :gift_credit, is_a: GiftCredit, required: true
        o.validate :payment, is_a: Payment2, required: true
        o.validate :sender, is_a: User, required: true
        o.validate :amount_micros, is_a: Integer, required: true
        o.validate :iso_currency_code, is_a: String, required: true
        o.validate :ip, is_a: String, required: true
        o.validate :cvv
      end

# Heresy! Ruby is a duck-typed language!
Then maybe `o.validate :user, responds_to: [:first_name, :last_name]`?

# Questions?
* Is this a good idea? Are we doing something fundamentally wrong?
* Will this lead to a story that will end up in The Daily WTF?
* Will it be useful if we switch to Ruby 2.1 keyword arguments? How would it need to change?

def your_method(user:, amount:, currency:)
  # Less cool, more yuck, user, user, user
  validate_arg user, is_a: User, name: "user"
  # Maybe this is possible using Ruby 2.1 local_variable_get?
  validate_arg :user, is_a: User
end
