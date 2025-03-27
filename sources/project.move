module TechMonk::MentorshipPlatform {

    use aptos_framework::signer;

    /// Struct representing a mentor.
    struct Mentor has store, key {
        expertise: vector<u8>,
        is_available: bool,
    }

    /// Function for registering as a mentor.
    public fun register_mentor(account: &signer, expertise: vector<u8>) {
        let mentor = Mentor {
            expertise,
            is_available: true,
        };
        move_to(account, mentor);
    }

    /// Function for a mentee to book a session with a mentor.
    public fun book_session(mentor_address: address) acquires Mentor {
        let mentor = borrow_global_mut<Mentor>(mentor_address);
        assert!(mentor.is_available, 1);
        mentor.is_available = false; // Mark mentor as unavailable after booking
    }
}
