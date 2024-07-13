// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'mechanic_repository.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$mechanicRepositoryHash() =>
    r'873d8bc00e9ca2e5e09aa6dda3a57909fe57e438';

/// See also [mechanicRepository].
@ProviderFor(mechanicRepository)
final mechanicRepositoryProvider =
    AutoDisposeProvider<MechanicRepository>.internal(
  mechanicRepository,
  name: r'mechanicRepositoryProvider',
  debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
      ? null
      : _$mechanicRepositoryHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

typedef MechanicRepositoryRef = AutoDisposeProviderRef<MechanicRepository>;
String _$fetchMechanicInfoHash() => r'e03e190c9447407191dedc8bac0bd5ac00530c9d';

/// Copied from Dart SDK
class _SystemHash {
  _SystemHash._();

  static int combine(int hash, int value) {
    // ignore: parameter_assignments
    hash = 0x1fffffff & (hash + value);
    // ignore: parameter_assignments
    hash = 0x1fffffff & (hash + ((0x0007ffff & hash) << 10));
    return hash ^ (hash >> 6);
  }

  static int finish(int hash) {
    // ignore: parameter_assignments
    hash = 0x1fffffff & (hash + ((0x03ffffff & hash) << 3));
    // ignore: parameter_assignments
    hash = hash ^ (hash >> 11);
    return 0x1fffffff & (hash + ((0x00003fff & hash) << 15));
  }
}

/// See also [fetchMechanicInfo].
@ProviderFor(fetchMechanicInfo)
const fetchMechanicInfoProvider = FetchMechanicInfoFamily();

/// See also [fetchMechanicInfo].
class FetchMechanicInfoFamily extends Family<AsyncValue<Mechanic>> {
  /// See also [fetchMechanicInfo].
  const FetchMechanicInfoFamily();

  /// See also [fetchMechanicInfo].
  FetchMechanicInfoProvider call(
    String mechanicId,
  ) {
    return FetchMechanicInfoProvider(
      mechanicId,
    );
  }

  @override
  FetchMechanicInfoProvider getProviderOverride(
    covariant FetchMechanicInfoProvider provider,
  ) {
    return call(
      provider.mechanicId,
    );
  }

  static const Iterable<ProviderOrFamily>? _dependencies = null;

  @override
  Iterable<ProviderOrFamily>? get dependencies => _dependencies;

  static const Iterable<ProviderOrFamily>? _allTransitiveDependencies = null;

  @override
  Iterable<ProviderOrFamily>? get allTransitiveDependencies =>
      _allTransitiveDependencies;

  @override
  String? get name => r'fetchMechanicInfoProvider';
}

/// See also [fetchMechanicInfo].
class FetchMechanicInfoProvider extends AutoDisposeFutureProvider<Mechanic> {
  /// See also [fetchMechanicInfo].
  FetchMechanicInfoProvider(
    String mechanicId,
  ) : this._internal(
          (ref) => fetchMechanicInfo(
            ref as FetchMechanicInfoRef,
            mechanicId,
          ),
          from: fetchMechanicInfoProvider,
          name: r'fetchMechanicInfoProvider',
          debugGetCreateSourceHash:
              const bool.fromEnvironment('dart.vm.product')
                  ? null
                  : _$fetchMechanicInfoHash,
          dependencies: FetchMechanicInfoFamily._dependencies,
          allTransitiveDependencies:
              FetchMechanicInfoFamily._allTransitiveDependencies,
          mechanicId: mechanicId,
        );

  FetchMechanicInfoProvider._internal(
    super._createNotifier, {
    required super.name,
    required super.dependencies,
    required super.allTransitiveDependencies,
    required super.debugGetCreateSourceHash,
    required super.from,
    required this.mechanicId,
  }) : super.internal();

  final String mechanicId;

  @override
  Override overrideWith(
    FutureOr<Mechanic> Function(FetchMechanicInfoRef provider) create,
  ) {
    return ProviderOverride(
      origin: this,
      override: FetchMechanicInfoProvider._internal(
        (ref) => create(ref as FetchMechanicInfoRef),
        from: from,
        name: null,
        dependencies: null,
        allTransitiveDependencies: null,
        debugGetCreateSourceHash: null,
        mechanicId: mechanicId,
      ),
    );
  }

  @override
  AutoDisposeFutureProviderElement<Mechanic> createElement() {
    return _FetchMechanicInfoProviderElement(this);
  }

  @override
  bool operator ==(Object other) {
    return other is FetchMechanicInfoProvider && other.mechanicId == mechanicId;
  }

  @override
  int get hashCode {
    var hash = _SystemHash.combine(0, runtimeType.hashCode);
    hash = _SystemHash.combine(hash, mechanicId.hashCode);

    return _SystemHash.finish(hash);
  }
}

mixin FetchMechanicInfoRef on AutoDisposeFutureProviderRef<Mechanic> {
  /// The parameter `mechanicId` of this provider.
  String get mechanicId;
}

class _FetchMechanicInfoProviderElement
    extends AutoDisposeFutureProviderElement<Mechanic>
    with FetchMechanicInfoRef {
  _FetchMechanicInfoProviderElement(super.provider);

  @override
  String get mechanicId => (origin as FetchMechanicInfoProvider).mechanicId;
}

String _$fetchRecommendedMechanicsHash() =>
    r'd5acfd32a70ead2ba39d0022615589a6605a3ff4';

/// See also [fetchRecommendedMechanics].
@ProviderFor(fetchRecommendedMechanics)
const fetchRecommendedMechanicsProvider = FetchRecommendedMechanicsFamily();

/// See also [fetchRecommendedMechanics].
class FetchRecommendedMechanicsFamily
    extends Family<AsyncValue<List<Mechanic>>> {
  /// See also [fetchRecommendedMechanics].
  const FetchRecommendedMechanicsFamily();

  /// See also [fetchRecommendedMechanics].
  FetchRecommendedMechanicsProvider call(
    String vehicleCategoryIdx,
    String serviceIdx,
  ) {
    return FetchRecommendedMechanicsProvider(
      vehicleCategoryIdx,
      serviceIdx,
    );
  }

  @override
  FetchRecommendedMechanicsProvider getProviderOverride(
    covariant FetchRecommendedMechanicsProvider provider,
  ) {
    return call(
      provider.vehicleCategoryIdx,
      provider.serviceIdx,
    );
  }

  static const Iterable<ProviderOrFamily>? _dependencies = null;

  @override
  Iterable<ProviderOrFamily>? get dependencies => _dependencies;

  static const Iterable<ProviderOrFamily>? _allTransitiveDependencies = null;

  @override
  Iterable<ProviderOrFamily>? get allTransitiveDependencies =>
      _allTransitiveDependencies;

  @override
  String? get name => r'fetchRecommendedMechanicsProvider';
}

/// See also [fetchRecommendedMechanics].
class FetchRecommendedMechanicsProvider
    extends AutoDisposeFutureProvider<List<Mechanic>> {
  /// See also [fetchRecommendedMechanics].
  FetchRecommendedMechanicsProvider(
    String vehicleCategoryIdx,
    String serviceIdx,
  ) : this._internal(
          (ref) => fetchRecommendedMechanics(
            ref as FetchRecommendedMechanicsRef,
            vehicleCategoryIdx,
            serviceIdx,
          ),
          from: fetchRecommendedMechanicsProvider,
          name: r'fetchRecommendedMechanicsProvider',
          debugGetCreateSourceHash:
              const bool.fromEnvironment('dart.vm.product')
                  ? null
                  : _$fetchRecommendedMechanicsHash,
          dependencies: FetchRecommendedMechanicsFamily._dependencies,
          allTransitiveDependencies:
              FetchRecommendedMechanicsFamily._allTransitiveDependencies,
          vehicleCategoryIdx: vehicleCategoryIdx,
          serviceIdx: serviceIdx,
        );

  FetchRecommendedMechanicsProvider._internal(
    super._createNotifier, {
    required super.name,
    required super.dependencies,
    required super.allTransitiveDependencies,
    required super.debugGetCreateSourceHash,
    required super.from,
    required this.vehicleCategoryIdx,
    required this.serviceIdx,
  }) : super.internal();

  final String vehicleCategoryIdx;
  final String serviceIdx;

  @override
  Override overrideWith(
    FutureOr<List<Mechanic>> Function(FetchRecommendedMechanicsRef provider)
        create,
  ) {
    return ProviderOverride(
      origin: this,
      override: FetchRecommendedMechanicsProvider._internal(
        (ref) => create(ref as FetchRecommendedMechanicsRef),
        from: from,
        name: null,
        dependencies: null,
        allTransitiveDependencies: null,
        debugGetCreateSourceHash: null,
        vehicleCategoryIdx: vehicleCategoryIdx,
        serviceIdx: serviceIdx,
      ),
    );
  }

  @override
  AutoDisposeFutureProviderElement<List<Mechanic>> createElement() {
    return _FetchRecommendedMechanicsProviderElement(this);
  }

  @override
  bool operator ==(Object other) {
    return other is FetchRecommendedMechanicsProvider &&
        other.vehicleCategoryIdx == vehicleCategoryIdx &&
        other.serviceIdx == serviceIdx;
  }

  @override
  int get hashCode {
    var hash = _SystemHash.combine(0, runtimeType.hashCode);
    hash = _SystemHash.combine(hash, vehicleCategoryIdx.hashCode);
    hash = _SystemHash.combine(hash, serviceIdx.hashCode);

    return _SystemHash.finish(hash);
  }
}

mixin FetchRecommendedMechanicsRef
    on AutoDisposeFutureProviderRef<List<Mechanic>> {
  /// The parameter `vehicleCategoryIdx` of this provider.
  String get vehicleCategoryIdx;

  /// The parameter `serviceIdx` of this provider.
  String get serviceIdx;
}

class _FetchRecommendedMechanicsProviderElement
    extends AutoDisposeFutureProviderElement<List<Mechanic>>
    with FetchRecommendedMechanicsRef {
  _FetchRecommendedMechanicsProviderElement(super.provider);

  @override
  String get vehicleCategoryIdx =>
      (origin as FetchRecommendedMechanicsProvider).vehicleCategoryIdx;
  @override
  String get serviceIdx =>
      (origin as FetchRecommendedMechanicsProvider).serviceIdx;
}
// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member, invalid_use_of_visible_for_testing_member
