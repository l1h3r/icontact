class IContactError < StandardError
end

# http://www.icontact.com/developerportal/documentation/http-status-codes/
module IContact
  class IContact::Forbidden < IContactError; end

  class IContact::BadRequest < IContactError; end

  class IContact::NotAcceptable < IContactError; end

  class IContact::NotAuthorized < IContactError; end

  class IContact::InternalServer < IContactError; end

  class IContact::NotImplemented < IContactError; end

  class IContact::PaymentRequest < IContactError; end

  class IContact::ResourceNotFound < IContactError; end

  class IContact::MethodNotAllowed < IContactError; end

  class IContact::InsufficientSpace < IContactError; end

  class IContact::ServiceUnavailable < IContactError; end

  class IContact::UnsupportedMediaType < IContactError; end

  class ErrorHandler
    MAPPED_ERRORS = {
      400 => IContact::BadRequest,
      401 => IContact::NotAuthorized,
      402 => IContact::PaymentRequest,
      403 => IContact::Forbidden,
      404 => IContact::ResourceNotFound,
      405 => IContact::MethodNotAllowed,
      406 => IContact::NotAcceptable,
      415 => IContact::UnsupportedMediaType,
      500 => IContact::InternalServer,
      501 => IContact::NotImplemented,
      503 => IContact::ServiceUnavailable,
      507 => IContact::InsufficientSpace
    }

    def initialize(response)
      error_class = MAPPED_ERRORS[response.status.to_i]
      message = Oj.load(response.body || {})['errors']

      if error_class
        raise error_class.new(message)
      else
        raise IContactError.new("#{response.status}: #{message}")
      end
    end

  end
end
