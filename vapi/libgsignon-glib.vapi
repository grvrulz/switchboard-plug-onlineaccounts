/* libgsignon-glib.vapi generated by vapigen-0.26, do not modify. */

[CCode (cprefix = "Signon", gir_namespace = "gSignon", gir_version = "1.0", lower_case_cprefix = "signon_")]
namespace Signon {
	[CCode (cheader_filename = "libgsignon-glib/signon-glib.h", type_id = "signon_auth_service_get_type ()")]
	public class AuthService : GLib.Object {
		[CCode (has_construct_function = false)]
		public AuthService ();
		public void clear ([CCode (scope = "async")] owned Signon.ClearCb cb);
		public void query_identities (Signon.IdentityFilter filter, string application_context, [CCode (scope = "async")] owned Signon.QueryIdentitiesCb cb);
		public void query_mechanisms (string method, [CCode (scope = "async")] owned Signon.QueryMechanismCb cb);
		public void query_methods ([CCode (scope = "async")] owned Signon.QueryMethodsCb cb);
	}
	[CCode (cheader_filename = "libgsignon-glib/signon-glib.h", type_id = "signon_auth_session_get_type ()")]
	public class AuthSession : GLib.Object {
		[CCode (has_construct_function = false)]
		public AuthSession (int id, string method_name) throws GLib.Error;
		public void cancel ();
		[CCode (has_construct_function = false)]
		public AuthSession.for_identity (Signon.Identity identity, string method_name) throws GLib.Error;
		public unowned string get_method ();
		[Deprecated (since = "1.8")]
		public void process (GLib.HashTable<string,GLib.Value?> session_data, string mechanism, [CCode (scope = "async")] owned Signon.AuthSessionProcessCb cb);
		public async GLib.Variant process_async (owned GLib.Variant session_data, string mechanism, GLib.Cancellable? cancellable) throws GLib.Error;
		public void query_available_mechanisms (string wanted_mechanisms, [CCode (scope = "async")] owned Signon.AuthSessionQueryAvailableMechanismsCb cb);
		[NoAccessorMethod]
		public Signon.Identity identity { owned get; construct; }
		public signal void state_changed (int state, string message);
	}
	[CCode (cheader_filename = "libgsignon-glib/signon-glib.h", type_id = "signon_identity_get_type ()")]
	public class Identity : GLib.Object {
		[CCode (has_construct_function = false)]
		public Identity ();
		public void add_reference (string reference, [CCode (scope = "async")] owned Signon.IdentityReferenceAddedCb cb);
		public Signon.AuthSession create_session (string method) throws GLib.Error;
		[CCode (has_construct_function = false)]
		public Identity.from_db (uint32 id);
		public void get_auth_session (Signon.AuthSession session, string method, [CCode (scope = "async")] owned Signon.IdentitySessionReadyCb cb);
		public unowned GLib.Error get_last_error ();
		public void query_info ([CCode (scope = "async")] owned Signon.IdentityInfoCb cb);
		public void remove ([CCode (scope = "async")] owned Signon.IdentityRemovedCb cb);
		public void remove_reference (string reference, [CCode (scope = "async")] owned Signon.IdentityReferenceRemovedCb cb);
		public void request_credentials_update (string message, [CCode (scope = "async")] owned Signon.IdentityCredentialsUpdatedCb cb);
		public void store_credentials_with_args (string? username, string? secret, bool store_secret, GLib.HashTable<string,string[]> methods, string? caption, string? realms, Signon.SecurityContext? owner, owned Signon.SecurityContextList? access_control_list, Signon.IdentityType type, [CCode (scope = "async")] owned Signon.IdentityStoreCredentialsCb cb);
		public void store_credentials_with_info (Signon.IdentityInfo info, [CCode (scope = "async")] owned Signon.IdentityStoreCredentialsCb cb);
		public void verify_user (GLib.Variant args, [CCode (scope = "async")] owned Signon.IdentityVerifyCb cb);
		[CCode (has_construct_function = false)]
		public Identity.with_context (string application_context);
		[CCode (has_construct_function = false)]
		public Identity.with_context_from_db (uint32 id, string application_context);
		[NoAccessorMethod]
		public string app_ctx { owned get; set; }
		[NoAccessorMethod]
		public uint id { get; set; }
		public signal void removed ();
		[HasEmitter]
		public signal void signout ();
	}
	[CCode (cheader_filename = "libgsignon-glib/signon-glib.h")]
	public class IdentityFilter : GLib.HashTable<string,GLib.Variant> {
	}
	[CCode (cheader_filename = "libgsignon-glib/signon-glib.h", copy_function = "g_boxed_copy", free_function = "g_boxed_free", type_id = "signon_identity_info_get_type ()")]
	[Compact]
	public class IdentityInfo {
		[CCode (has_construct_function = false)]
		public IdentityInfo ();
		public void access_control_list_append (owned Signon.SecurityContext security_context);
		public Signon.IdentityInfo copy ();
		public void free ();
		public unowned Signon.SecurityContextList get_access_control_list ();
		public unowned string get_caption ();
		public int get_id ();
		public Signon.IdentityType get_identity_type ();
		public unowned GLib.HashTable<string,string[]> get_methods ();
		public unowned Signon.SecurityContext get_owner ();
		[CCode (array_length = false, array_null_terminated = true)]
		public unowned string[] get_realms ();
		public bool get_storing_secret ();
		public unowned string get_username ();
		public void own_methods (GLib.HashTable<string,string[]> methods);
		public void remove_method (string method);
		public void set_access_control_list (Signon.SecurityContextList access_control_list);
		public void set_caption (string caption);
		public void set_identity_type (Signon.IdentityType type);
		public void set_method (string method, [CCode (array_length = false, array_null_terminated = true)] string[] mechanisms);
		public void set_methods (GLib.HashTable<string,string[]> methods);
		public void set_owner (Signon.SecurityContext owner);
		public void set_owner_from_values (string system_context, string application_context);
		public void set_realms ([CCode (array_length = false, array_null_terminated = true)] string[] realms);
		public void set_secret (string secret, bool store_secret);
		public void set_username (string username);
	}
	[CCode (cheader_filename = "libgsignon-glib/signon-glib.h")]
	public class IdentityList : GLib.List<Signon.Identity> {
	}
	[CCode (cheader_filename = "libgsignon-glib/signon-glib.h", copy_function = "g_boxed_copy", free_function = "g_boxed_free", type_id = "signon_security_context_get_type ()")]
	[Compact]
	public class SecurityContext {
		public weak string app_ctx;
		public weak string sys_ctx;
		[CCode (has_construct_function = false)]
		public SecurityContext ();
		public GLib.Variant build_variant ();
		public Signon.SecurityContext copy ();
		public static Signon.SecurityContext deconstruct_variant (GLib.Variant variant);
		public void free ();
		[CCode (has_construct_function = false)]
		public SecurityContext.from_values (string system_context, string application_context);
		public unowned string get_application_context ();
		public unowned string get_system_context ();
		public void set_application_context (string application_context);
		public void set_system_context (string system_context);
	}
	[CCode (cheader_filename = "libgsignon-glib/signon-glib.h", copy_function = "signon_security_context_list_copy", free_function = "signon_security_context_list_free")]
	[Compact]
	public class SecurityContextList : GLib.List<Signon.SecurityContext> {
		public GLib.Variant build_variant ();
		public SecurityContextList.deconstruct_variant (GLib.Variant variant);
	}
	[CCode (cheader_filename = "libgsignon-glib/signon-glib.h", cprefix = "SIGNON_IDENTITY_TYPE_", type_id = "signon_identity_type_get_type ()")]
	[Flags]
	public enum IdentityType {
		OTHER,
		APP,
		WEB,
		NETWORK
	}
	[CCode (cheader_filename = "libgsignon-glib/signon-glib.h", cprefix = "SIGNON_POLICY_", type_id = "signon_session_data_ui_policy_get_type ()")]
	public enum SessionDataUiPolicy {
		DEFAULT,
		REQUEST_PASSWORD,
		NO_USER_INTERACTION,
		VALIDATION
	}
	[CCode (cheader_filename = "libgsignon-glib/signon-glib.h", cprefix = "")]
	public errordomain Error {
		[CCode (cname = "com.google.code.AccountsSSO.gSingleSignOn.Error.Unknown")]
		UNKNOWN,
		[CCode (cname = "com.google.code.AccountsSSO.gSingleSignOn.Error.InternalServer")]
		INTERNAL_SERVER,
		[CCode (cname = "com.google.code.AccountsSSO.gSingleSignOn.Error.InternalCommunication")]
		INTERNAL_COMMUNICATION,
		[CCode (cname = "com.google.code.AccountsSSO.gSingleSignOn.Error.PermissionDenied")]
		PERMISSION_DENIED,
		[CCode (cname = "com.google.code.AccountsSSO.gSingleSignOn.Error.MethodNotKnown")]
		METHOD_NOT_KNOWN,
		[CCode (cname = "com.google.code.AccountsSSO.gSingleSignOn.Error.ServiceNotAvailable")]
		SERVICE_NOT_AVAILABLE,
		[CCode (cname = "com.google.code.AccountsSSO.gSingleSignOn.Error.InvalidQuery")]
		INVALID_QUERY,
		[CCode (cname = "com.google.code.AccountsSSO.gSingleSignOn.Error.MethodNotAvailable")]
		METHOD_NOT_AVAILABLE,
		[CCode (cname = "com.google.code.AccountsSSO.gSingleSignOn.Error.IdentityNotFound")]
		IDENTITY_NOT_FOUND,
		[CCode (cname = "com.google.code.AccountsSSO.gSingleSignOn.Error.StoreFailed")]
		STORE_FAILED,
		[CCode (cname = "com.google.code.AccountsSSO.gSingleSignOn.Error.RemoveFailed")]
		REMOVE_FAILED,
		[CCode (cname = "com.google.code.AccountsSSO.gSingleSignOn.Error.SignOutFailed")]
		SIGNOUT_FAILED,
		[CCode (cname = "com.google.code.AccountsSSO.gSingleSignOn.Error.IdentityOperationCanceled")]
		IDENTITY_OPERATION_CANCELED,
		[CCode (cname = "com.google.code.AccountsSSO.gSingleSignOn.Error.CredentialsNotAvailable")]
		CREDENTIALS_NOT_AVAILABLE,
		[CCode (cname = "com.google.code.AccountsSSO.gSingleSignOn.Error.ReferenceNotFound")]
		REFERENCE_NOT_FOUND,
		[CCode (cname = "com.google.code.AccountsSSO.gSingleSignOn.Error.MechanismNotAvailable")]
		MECHANISM_NOT_AVAILABLE,
		[CCode (cname = "com.google.code.AccountsSSO.gSingleSignOn.Error.MissingData")]
		MISSING_DATA,
		[CCode (cname = "com.google.code.AccountsSSO.gSingleSignOn.Error.InvalidCredentials")]
		INVALID_CREDENTIALS,
		[CCode (cname = "com.google.code.AccountsSSO.gSingleSignOn.Error.NotAuthorized")]
		NOT_AUTHORIZED,
		[CCode (cname = "com.google.code.AccountsSSO.gSingleSignOn.Error.WrongState")]
		WRONG_STATE,
		[CCode (cname = "com.google.code.AccountsSSO.gSingleSignOn.Error.OperationNotSupported")]
		OPERATION_NOT_SUPPORTED,
		[CCode (cname = "com.google.code.AccountsSSO.gSingleSignOn.Error.NoConnection")]
		NO_CONNECTION,
		[CCode (cname = "com.google.code.AccountsSSO.gSingleSignOn.Error.Network")]
		NETWORK,
		[CCode (cname = "com.google.code.AccountsSSO.gSingleSignOn.Error.Ssl")]
		SSL,
		[CCode (cname = "com.google.code.AccountsSSO.gSingleSignOn.Error.Runtime")]
		RUNTIME,
		[CCode (cname = "com.google.code.AccountsSSO.gSingleSignOn.Error.SessionCanceled")]
		SESSION_CANCELED,
		[CCode (cname = "com.google.code.AccountsSSO.gSingleSignOn.Error.TimedOut")]
		TIMED_OUT,
		[CCode (cname = "com.google.code.AccountsSSO.gSingleSignOn.Error.UserInteraction")]
		USER_INTERACTION,
		[CCode (cname = "com.google.code.AccountsSSO.gSingleSignOn.Error.OperationFailed")]
		OPERATION_FAILED,
		[CCode (cname = "com.google.code.AccountsSSO.gSingleSignOn.Error.EncryptionFailed")]
		ENCRYPTION_FAILED,
		[CCode (cname = "com.google.code.AccountsSSO.gSingleSignOn.Error.TOSNotAccepted")]
		TOS_NOT_ACCEPTED,
		[CCode (cname = "com.google.code.AccountsSSO.gSingleSignOn.Error.ForgotPassword")]
		FORGOT_PASSWORD,
		[CCode (cname = "com.google.code.AccountsSSO.gSingleSignOn.Error.MethodOrMechanismNotAllowed")]
		METHOD_OR_MECHANISM_NOT_ALLOWED,
		[CCode (cname = "com.google.code.AccountsSSO.gSingleSignOn.Error.IncorrectDate")]
		INCORRECT_DATE,
		[CCode (cname = "com.google.code.AccountsSSO.gSingleSignOn.Error.User")]
		USER_ERROR;
		public static GLib.Quark quark ();
	}
	[CCode (cheader_filename = "libgsignon-glib/signon-glib.h", instance_pos = 3.9)]
	public delegate void AuthSessionProcessCb (Signon.AuthSession self, owned GLib.HashTable<string,GLib.Value?> session_data, GLib.Error error);
	[CCode (cheader_filename = "libgsignon-glib/signon-glib.h", instance_pos = 3.9)]
	public delegate void AuthSessionQueryAvailableMechanismsCb (Signon.AuthSession self, [CCode (array_length = false, array_null_terminated = true)] owned string[] mechanisms, GLib.Error error);
	[CCode (cheader_filename = "libgsignon-glib/signon-glib.h", instance_pos = 3.9)]
	public delegate void AuthSessionQueryAvailableMethodsCb (Signon.AuthSession self, [CCode (array_length = false, array_null_terminated = true)] owned string[] mechanisms, GLib.Error error);
	[CCode (cheader_filename = "libgsignon-glib/signon-glib.h", instance_pos = 3.9)]
	public delegate void ClearCb (Signon.AuthService auth_service, bool success, GLib.Error error);
	[CCode (cheader_filename = "libgsignon-glib/signon-glib.h", instance_pos = 2.9)]
	public delegate void IdentityCredentialsUpdatedCb (Signon.Identity self, GLib.Error error);
	[CCode (cheader_filename = "libgsignon-glib/signon-glib.h", instance_pos = 3.9)]
	public delegate void IdentityInfoCb (Signon.Identity self, Signon.IdentityInfo info, GLib.Error error);
	[CCode (cheader_filename = "libgsignon-glib/signon-glib.h", instance_pos = 2.9)]
	public delegate void IdentityReferenceAddedCb (Signon.Identity self, GLib.Error error);
	[CCode (cheader_filename = "libgsignon-glib/signon-glib.h", instance_pos = 2.9)]
	public delegate void IdentityReferenceRemovedCb (Signon.Identity self, GLib.Error error);
	[CCode (cheader_filename = "libgsignon-glib/signon-glib.h", instance_pos = 2.9)]
	public delegate void IdentityRemovedCb (Signon.Identity self, GLib.Error error);
	[CCode (cheader_filename = "libgsignon-glib/signon-glib.h", has_target = false)]
	public delegate void IdentitySessionReadyCb (Signon.AuthSession self, GLib.Error error, GLib.DBusConnection connection, string bus_name, string object_path);
	[CCode (cheader_filename = "libgsignon-glib/signon-glib.h", instance_pos = 2.9)]
	public delegate void IdentitySignedOutCb (Signon.Identity self, GLib.Error error);
	[CCode (cheader_filename = "libgsignon-glib/signon-glib.h", instance_pos = 3.9)]
	public delegate void IdentityStoreCredentialsCb (Signon.Identity self, uint32 id, GLib.Error error);
	[CCode (cheader_filename = "libgsignon-glib/signon-glib.h", instance_pos = 3.9)]
	public delegate void IdentityVerifyCb (Signon.Identity self, bool valid, GLib.Error error);
	[CCode (cheader_filename = "libgsignon-glib/signon-glib.h", instance_pos = 2.9)]
	public delegate void IdentityVoidCb (Signon.Identity self, GLib.Error error);
	[CCode (cheader_filename = "libgsignon-glib/signon-glib.h", instance_pos = 3.9)]
	public delegate void QueryIdentitiesCb (Signon.AuthService auth_service, owned Signon.IdentityList identities, GLib.Error error);
	[CCode (cheader_filename = "libgsignon-glib/signon-glib.h", instance_pos = 4.9)]
	public delegate void QueryMechanismCb (Signon.AuthService auth_service, string method, [CCode (array_length = false, array_null_terminated = true)] owned string[] mechanisms, GLib.Error error);
	[CCode (cheader_filename = "libgsignon-glib/signon-glib.h", instance_pos = 3.9)]
	public delegate void QueryMethodsCb (Signon.AuthService auth_service, [CCode (array_length = false, array_null_terminated = true)] owned string[] methods, GLib.Error error);
	[CCode (cheader_filename = "libgsignon-glib/signon-glib.h", cname = "SIGNON_SESSION_DATA_CAPTION")]
	public const string SESSION_DATA_CAPTION;
	[CCode (cheader_filename = "libgsignon-glib/signon-glib.h", cname = "SIGNON_SESSION_DATA_PROXY")]
	public const string SESSION_DATA_PROXY;
	[CCode (cheader_filename = "libgsignon-glib/signon-glib.h", cname = "SIGNON_SESSION_DATA_REALM")]
	public const string SESSION_DATA_REALM;
	[CCode (cheader_filename = "libgsignon-glib/signon-glib.h", cname = "SIGNON_SESSION_DATA_RENEW_TOKEN")]
	public const string SESSION_DATA_RENEW_TOKEN;
	[CCode (cheader_filename = "libgsignon-glib/signon-glib.h", cname = "SIGNON_SESSION_DATA_SECRET")]
	public const string SESSION_DATA_SECRET;
	[CCode (cheader_filename = "libgsignon-glib/signon-glib.h", cname = "SIGNON_SESSION_DATA_TIMEOUT")]
	public const string SESSION_DATA_TIMEOUT;
	[CCode (cheader_filename = "libgsignon-glib/signon-glib.h", cname = "SIGNON_SESSION_DATA_UI_POLICY")]
	public const string SESSION_DATA_UI_POLICY;
	[CCode (cheader_filename = "libgsignon-glib/signon-glib.h", cname = "SIGNON_SESSION_DATA_USERNAME")]
	public const string SESSION_DATA_USERNAME;
	[CCode (cheader_filename = "libgsignon-glib/signon-glib.h", cname = "SIGNON_SESSION_DATA_WINDOW_ID")]
	public const string SESSION_DATA_WINDOW_ID;
}
