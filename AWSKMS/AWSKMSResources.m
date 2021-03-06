//
// Copyright 2010-2019 Amazon.com, Inc. or its affiliates. All Rights Reserved.
//
// Licensed under the Apache License, Version 2.0 (the "License").
// You may not use this file except in compliance with the License.
// A copy of the License is located at
//
// http://aws.amazon.com/apache2.0
//
// or in the "license" file accompanying this file. This file is distributed
// on an "AS IS" BASIS, WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either
// express or implied. See the License for the specific language governing
// permissions and limitations under the License.
//

#import "AWSKMSResources.h"
#import <AWSCore/AWSCocoaLumberjack.h>

@interface AWSKMSResources ()

@property (nonatomic, strong) NSDictionary *definitionDictionary;

@end

@implementation AWSKMSResources

+ (instancetype)sharedInstance {
    static AWSKMSResources *_sharedResources = nil;
    static dispatch_once_t once_token;

    dispatch_once(&once_token, ^{
        _sharedResources = [AWSKMSResources new];
    });

    return _sharedResources;
}

- (NSDictionary *)JSONObject {
    return self.definitionDictionary;
}

- (instancetype)init {
    if (self = [super init]) {
        //init method
        NSError *error = nil;
        _definitionDictionary = [NSJSONSerialization JSONObjectWithData:[[self definitionString] dataUsingEncoding:NSUTF8StringEncoding]
                                                                options:kNilOptions
                                                                  error:&error];
        if (_definitionDictionary == nil) {
            if (error) {
                AWSDDLogError(@"Failed to parse JSON service definition: %@",error);
            }
        }
    }
    return self;
}

- (NSString *)definitionString {
    return @"{\
  \"version\":\"2.0\",\
  \"metadata\":{\
    \"apiVersion\":\"2014-11-01\",\
    \"endpointPrefix\":\"kms\",\
    \"jsonVersion\":\"1.1\",\
    \"protocol\":\"json\",\
    \"serviceAbbreviation\":\"KMS\",\
    \"serviceFullName\":\"AWS Key Management Service\",\
    \"serviceId\":\"KMS\",\
    \"signatureVersion\":\"v4\",\
    \"targetPrefix\":\"TrentService\",\
    \"uid\":\"kms-2014-11-01\"\
  },\
  \"operations\":{\
    \"CancelKeyDeletion\":{\
      \"name\":\"CancelKeyDeletion\",\
      \"http\":{\
        \"method\":\"POST\",\
        \"requestUri\":\"/\"\
      },\
      \"input\":{\"shape\":\"CancelKeyDeletionRequest\"},\
      \"output\":{\"shape\":\"CancelKeyDeletionResponse\"},\
      \"errors\":[\
        {\"shape\":\"NotFoundException\"},\
        {\"shape\":\"InvalidArnException\"},\
        {\"shape\":\"DependencyTimeoutException\"},\
        {\"shape\":\"KMSInternalException\"},\
        {\"shape\":\"KMSInvalidStateException\"}\
      ],\
      \"documentation\":\"<p>Cancels the deletion of a customer master key (CMK). When this operation is successful, the CMK is set to the <code>Disabled</code> state. To enable a CMK, use <a>EnableKey</a>. You cannot perform this operation on a CMK in a different AWS account.</p> <p>For more information about scheduling and canceling deletion of a CMK, see <a href=\\\"https://docs.aws.amazon.com/kms/latest/developerguide/deleting-keys.html\\\">Deleting Customer Master Keys</a> in the <i>AWS Key Management Service Developer Guide</i>.</p> <p>The result of this operation varies with the key state of the CMK. For details, see <a href=\\\"https://docs.aws.amazon.com/kms/latest/developerguide/key-state.html\\\">How Key State Affects Use of a Customer Master Key</a> in the <i>AWS Key Management Service Developer Guide</i>.</p>\"\
    },\
    \"ConnectCustomKeyStore\":{\
      \"name\":\"ConnectCustomKeyStore\",\
      \"http\":{\
        \"method\":\"POST\",\
        \"requestUri\":\"/\"\
      },\
      \"input\":{\"shape\":\"ConnectCustomKeyStoreRequest\"},\
      \"output\":{\"shape\":\"ConnectCustomKeyStoreResponse\"},\
      \"errors\":[\
        {\"shape\":\"CloudHsmClusterNotActiveException\"},\
        {\"shape\":\"CustomKeyStoreInvalidStateException\"},\
        {\"shape\":\"CustomKeyStoreNotFoundException\"},\
        {\"shape\":\"KMSInternalException\"},\
        {\"shape\":\"CloudHsmClusterInvalidConfigurationException\"}\
      ],\
      \"documentation\":\"<p>Connects or reconnects a <a href=\\\"https://docs.aws.amazon.com/kms/latest/developerguide/custom-key-store-overview.html\\\">custom key store</a> to its associated AWS CloudHSM cluster.</p> <p>The custom key store must be connected before you can create customer master keys (CMKs) in the key store or use the CMKs it contains. You can disconnect and reconnect a custom key store at any time.</p> <p>To connect a custom key store, its associated AWS CloudHSM cluster must have at least one active HSM. To get the number of active HSMs in a cluster, use the <a href=\\\"https://docs.aws.amazon.com/cloudhsm/latest/APIReference/API_DescribeClusters.html\\\">DescribeClusters</a> operation. To add HSMs to the cluster, use the <a href=\\\"https://docs.aws.amazon.com/cloudhsm/latest/APIReference/API_CreateHsm.html\\\">CreateHsm</a> operation.</p> <p>The connection process can take an extended amount of time to complete; up to 20 minutes. This operation starts the connection process, but it does not wait for it to complete. When it succeeds, this operation quickly returns an HTTP 200 response and a JSON object with no properties. However, this response does not indicate that the custom key store is connected. To get the connection state of the custom key store, use the <a>DescribeCustomKeyStores</a> operation.</p> <p>During the connection process, AWS KMS finds the AWS CloudHSM cluster that is associated with the custom key store, creates the connection infrastructure, connects to the cluster, logs into the AWS CloudHSM client as the <a href=\\\"https://docs.aws.amazon.com/kms/latest/developerguide/key-store-concepts.html#concept-kmsuser\\\"> <code>kmsuser</code> crypto user</a> (CU), and rotates its password.</p> <p>The <code>ConnectCustomKeyStore</code> operation might fail for various reasons. To find the reason, use the <a>DescribeCustomKeyStores</a> operation and see the <code>ConnectionErrorCode</code> in the response. For help interpreting the <code>ConnectionErrorCode</code>, see <a>CustomKeyStoresListEntry</a>.</p> <p>To fix the failure, use the <a>DisconnectCustomKeyStore</a> operation to disconnect the custom key store, correct the error, use the <a>UpdateCustomKeyStore</a> operation if necessary, and then use <code>ConnectCustomKeyStore</code> again.</p> <p>If you are having trouble connecting or disconnecting a custom key store, see <a href=\\\"https://docs.aws.amazon.com/kms/latest/developerguide/fix-keystore.html\\\">Troubleshooting a Custom Key Store</a> in the <i>AWS Key Management Service Developer Guide</i>.</p>\"\
    },\
    \"CreateAlias\":{\
      \"name\":\"CreateAlias\",\
      \"http\":{\
        \"method\":\"POST\",\
        \"requestUri\":\"/\"\
      },\
      \"input\":{\"shape\":\"CreateAliasRequest\"},\
      \"errors\":[\
        {\"shape\":\"DependencyTimeoutException\"},\
        {\"shape\":\"AlreadyExistsException\"},\
        {\"shape\":\"NotFoundException\"},\
        {\"shape\":\"InvalidAliasNameException\"},\
        {\"shape\":\"KMSInternalException\"},\
        {\"shape\":\"LimitExceededException\"},\
        {\"shape\":\"KMSInvalidStateException\"}\
      ],\
      \"documentation\":\"<p>Creates a display name for a customer managed customer master key (CMK). You can use an alias to identify a CMK in selected operations, such as <a>Encrypt</a> and <a>GenerateDataKey</a>. </p> <p>Each CMK can have multiple aliases, but each alias points to only one CMK. The alias name must be unique in the AWS account and region. To simplify code that runs in multiple regions, use the same alias name, but point it to a different CMK in each region. </p> <p>Because an alias is not a property of a CMK, you can delete and change the aliases of a CMK without affecting the CMK. Also, aliases do not appear in the response from the <a>DescribeKey</a> operation. To get the aliases of all CMKs, use the <a>ListAliases</a> operation.</p> <p>The alias name must begin with <code>alias/</code> followed by a name, such as <code>alias/ExampleAlias</code>. It can contain only alphanumeric characters, forward slashes (/), underscores (_), and dashes (-). The alias name cannot begin with <code>alias/aws/</code>. The <code>alias/aws/</code> prefix is reserved for <a href=\\\"https://docs.aws.amazon.com/kms/latest/developerguide/concepts.html#aws-managed-cmk\\\">AWS managed CMKs</a>. </p> <p>The alias and the CMK it is mapped to must be in the same AWS account and the same region. You cannot perform this operation on an alias in a different AWS account.</p> <p>To map an existing alias to a different CMK, call <a>UpdateAlias</a>.</p> <p>The result of this operation varies with the key state of the CMK. For details, see <a href=\\\"https://docs.aws.amazon.com/kms/latest/developerguide/key-state.html\\\">How Key State Affects Use of a Customer Master Key</a> in the <i>AWS Key Management Service Developer Guide</i>.</p>\"\
    },\
    \"CreateCustomKeyStore\":{\
      \"name\":\"CreateCustomKeyStore\",\
      \"http\":{\
        \"method\":\"POST\",\
        \"requestUri\":\"/\"\
      },\
      \"input\":{\"shape\":\"CreateCustomKeyStoreRequest\"},\
      \"output\":{\"shape\":\"CreateCustomKeyStoreResponse\"},\
      \"errors\":[\
        {\"shape\":\"CloudHsmClusterInUseException\"},\
        {\"shape\":\"CustomKeyStoreNameInUseException\"},\
        {\"shape\":\"CloudHsmClusterNotFoundException\"},\
        {\"shape\":\"KMSInternalException\"},\
        {\"shape\":\"CloudHsmClusterNotActiveException\"},\
        {\"shape\":\"IncorrectTrustAnchorException\"},\
        {\"shape\":\"CloudHsmClusterInvalidConfigurationException\"}\
      ],\
      \"documentation\":\"<p>Creates a <a href=\\\"https://docs.aws.amazon.com/kms/latest/developerguide/custom-key-store-overview.html\\\">custom key store</a> that is associated with an <a href=\\\"https://docs.aws.amazon.com/cloudhsm/latest/userguide/clusters.html\\\">AWS CloudHSM cluster</a> that you own and manage.</p> <p>This operation is part of the <a href=\\\"https://docs.aws.amazon.com/kms/latest/developerguide/custom-key-store-overview.html\\\">Custom Key Store feature</a> feature in AWS KMS, which combines the convenience and extensive integration of AWS KMS with the isolation and control of a single-tenant key store.</p> <p>Before you create the custom key store, you must assemble the required elements, including an AWS CloudHSM cluster that fulfills the requirements for a custom key store. For details about the required elements, see <a href=\\\"https://docs.aws.amazon.com/kms/latest/developerguide/create-keystore.html#before-keystore\\\">Assemble the Prerequisites</a> in the <i>AWS Key Management Service Developer Guide</i>.</p> <p>When the operation completes successfully, it returns the ID of the new custom key store. Before you can use your new custom key store, you need to use the <a>ConnectCustomKeyStore</a> operation to connect the new key store to its AWS CloudHSM cluster. Even if you are not going to use your custom key store immediately, you might want to connect it to verify that all settings are correct and then disconnect it until you are ready to use it.</p> <p>For help with failures, see <a href=\\\"https://docs.aws.amazon.com/kms/latest/developerguide/fix-keystore.html\\\">Troubleshooting a Custom Key Store</a> in the <i>AWS Key Management Service Developer Guide</i>.</p>\"\
    },\
    \"CreateGrant\":{\
      \"name\":\"CreateGrant\",\
      \"http\":{\
        \"method\":\"POST\",\
        \"requestUri\":\"/\"\
      },\
      \"input\":{\"shape\":\"CreateGrantRequest\"},\
      \"output\":{\"shape\":\"CreateGrantResponse\"},\
      \"errors\":[\
        {\"shape\":\"NotFoundException\"},\
        {\"shape\":\"DisabledException\"},\
        {\"shape\":\"DependencyTimeoutException\"},\
        {\"shape\":\"InvalidArnException\"},\
        {\"shape\":\"KMSInternalException\"},\
        {\"shape\":\"InvalidGrantTokenException\"},\
        {\"shape\":\"LimitExceededException\"},\
        {\"shape\":\"KMSInvalidStateException\"}\
      ],\
      \"documentation\":\"<p>Adds a grant to a customer master key (CMK). The grant allows the grantee principal to use the CMK when the conditions specified in the grant are met. When setting permissions, grants are an alternative to key policies. </p> <p>To create a grant that allows a cryptographic operation only when the encryption context in the operation request matches or includes a specified encryption context, use the <code>Constraints</code> parameter. For details, see <a>GrantConstraints</a>.</p> <p>To perform this operation on a CMK in a different AWS account, specify the key ARN in the value of the <code>KeyId</code> parameter. For more information about grants, see <a href=\\\"https://docs.aws.amazon.com/kms/latest/developerguide/grants.html\\\">Grants</a> in the <i> <i>AWS Key Management Service Developer Guide</i> </i>.</p> <p>The result of this operation varies with the key state of the CMK. For details, see <a href=\\\"https://docs.aws.amazon.com/kms/latest/developerguide/key-state.html\\\">How Key State Affects Use of a Customer Master Key</a> in the <i>AWS Key Management Service Developer Guide</i>.</p>\"\
    },\
    \"CreateKey\":{\
      \"name\":\"CreateKey\",\
      \"http\":{\
        \"method\":\"POST\",\
        \"requestUri\":\"/\"\
      },\
      \"input\":{\"shape\":\"CreateKeyRequest\"},\
      \"output\":{\"shape\":\"CreateKeyResponse\"},\
      \"errors\":[\
        {\"shape\":\"MalformedPolicyDocumentException\"},\
        {\"shape\":\"DependencyTimeoutException\"},\
        {\"shape\":\"InvalidArnException\"},\
        {\"shape\":\"UnsupportedOperationException\"},\
        {\"shape\":\"KMSInternalException\"},\
        {\"shape\":\"LimitExceededException\"},\
        {\"shape\":\"TagException\"},\
        {\"shape\":\"CustomKeyStoreNotFoundException\"},\
        {\"shape\":\"CustomKeyStoreInvalidStateException\"},\
        {\"shape\":\"CloudHsmClusterInvalidConfigurationException\"}\
      ],\
      \"documentation\":\"<p>Creates a customer managed <a href=\\\"https://docs.aws.amazon.com/kms/latest/developerguide/concepts.html#master_keys\\\">customer master key</a> (CMK) in your AWS account.</p> <p>You can use a CMK to encrypt small amounts of data (up to 4096 bytes) directly. But CMKs are more commonly used to encrypt the <a href=\\\"https://docs.aws.amazon.com/kms/latest/developerguide/concepts.html#data-keys\\\">data keys</a> that are used to encrypt data.</p> <p>To create a CMK for imported key material, use the <code>Origin</code> parameter with a value of <code>EXTERNAL</code>.</p> <p>To create a CMK in a <a href=\\\"https://docs.aws.amazon.com/kms/latest/developerguide/custom-key-store-overview.html\\\">custom key store</a>, use the <code>CustomKeyStoreId</code> parameter to specify the custom key store. You must also use the <code>Origin</code> parameter with a value of <code>AWS_CLOUDHSM</code>. The AWS CloudHSM cluster that is associated with the custom key store must have at least two active HSMs in different Availability Zones in the AWS Region.</p> <p>You cannot use this operation to create a CMK in a different AWS account.</p>\"\
    },\
    \"Decrypt\":{\
      \"name\":\"Decrypt\",\
      \"http\":{\
        \"method\":\"POST\",\
        \"requestUri\":\"/\"\
      },\
      \"input\":{\"shape\":\"DecryptRequest\"},\
      \"output\":{\"shape\":\"DecryptResponse\"},\
      \"errors\":[\
        {\"shape\":\"NotFoundException\"},\
        {\"shape\":\"DisabledException\"},\
        {\"shape\":\"InvalidCiphertextException\"},\
        {\"shape\":\"KeyUnavailableException\"},\
        {\"shape\":\"DependencyTimeoutException\"},\
        {\"shape\":\"InvalidGrantTokenException\"},\
        {\"shape\":\"KMSInternalException\"},\
        {\"shape\":\"KMSInvalidStateException\"}\
      ],\
      \"documentation\":\"<p>Decrypts ciphertext. Ciphertext is plaintext that has been previously encrypted by using any of the following operations:</p> <ul> <li> <p> <a>GenerateDataKey</a> </p> </li> <li> <p> <a>GenerateDataKeyWithoutPlaintext</a> </p> </li> <li> <p> <a>Encrypt</a> </p> </li> </ul> <p>Whenever possible, use key policies to give users permission to call the Decrypt operation on the CMK, instead of IAM policies. Otherwise, you might create an IAM user policy that gives the user Decrypt permission on all CMKs. This user could decrypt ciphertext that was encrypted by CMKs in other accounts if the key policy for the cross-account CMK permits it. If you must use an IAM policy for <code>Decrypt</code> permissions, limit the user to particular CMKs or particular trusted accounts.</p> <p>The result of this operation varies with the key state of the CMK. For details, see <a href=\\\"https://docs.aws.amazon.com/kms/latest/developerguide/key-state.html\\\">How Key State Affects Use of a Customer Master Key</a> in the <i>AWS Key Management Service Developer Guide</i>.</p>\"\
    },\
    \"DeleteAlias\":{\
      \"name\":\"DeleteAlias\",\
      \"http\":{\
        \"method\":\"POST\",\
        \"requestUri\":\"/\"\
      },\
      \"input\":{\"shape\":\"DeleteAliasRequest\"},\
      \"errors\":[\
        {\"shape\":\"DependencyTimeoutException\"},\
        {\"shape\":\"NotFoundException\"},\
        {\"shape\":\"KMSInternalException\"},\
        {\"shape\":\"KMSInvalidStateException\"}\
      ],\
      \"documentation\":\"<p>Deletes the specified alias. You cannot perform this operation on an alias in a different AWS account. </p> <p>Because an alias is not a property of a CMK, you can delete and change the aliases of a CMK without affecting the CMK. Also, aliases do not appear in the response from the <a>DescribeKey</a> operation. To get the aliases of all CMKs, use the <a>ListAliases</a> operation. </p> <p>Each CMK can have multiple aliases. To change the alias of a CMK, use <a>DeleteAlias</a> to delete the current alias and <a>CreateAlias</a> to create a new alias. To associate an existing alias with a different customer master key (CMK), call <a>UpdateAlias</a>.</p>\"\
    },\
    \"DeleteCustomKeyStore\":{\
      \"name\":\"DeleteCustomKeyStore\",\
      \"http\":{\
        \"method\":\"POST\",\
        \"requestUri\":\"/\"\
      },\
      \"input\":{\"shape\":\"DeleteCustomKeyStoreRequest\"},\
      \"output\":{\"shape\":\"DeleteCustomKeyStoreResponse\"},\
      \"errors\":[\
        {\"shape\":\"CustomKeyStoreHasCMKsException\"},\
        {\"shape\":\"CustomKeyStoreInvalidStateException\"},\
        {\"shape\":\"CustomKeyStoreNotFoundException\"},\
        {\"shape\":\"KMSInternalException\"}\
      ],\
      \"documentation\":\"<p>Deletes a <a href=\\\"https://docs.aws.amazon.com/kms/latest/developerguide/custom-key-store-overview.html\\\">custom key store</a>. This operation does not delete the AWS CloudHSM cluster that is associated with the custom key store, or affect any users or keys in the cluster.</p> <p>The custom key store that you delete cannot contain any AWS KMS <a href=\\\"https://docs.aws.amazon.com/kms/latest/developerguide/concepts.html#master_keys\\\">customer master keys (CMKs)</a>. Before deleting the key store, verify that you will never need to use any of the CMKs in the key store for any cryptographic operations. Then, use <a>ScheduleKeyDeletion</a> to delete the AWS KMS customer master keys (CMKs) from the key store. When the scheduled waiting period expires, the <code>ScheduleKeyDeletion</code> operation deletes the CMKs. Then it makes a best effort to delete the key material from the associated cluster. However, you might need to manually <a href=\\\"https://docs.aws.amazon.com/kms/latest/developerguide/fix-keystore.html#fix-keystore-orphaned-key\\\">delete the orphaned key material</a> from the cluster and its backups.</p> <p>After all CMKs are deleted from AWS KMS, use <a>DisconnectCustomKeyStore</a> to disconnect the key store from AWS KMS. Then, you can delete the custom key store.</p> <p>Instead of deleting the custom key store, consider using <a>DisconnectCustomKeyStore</a> to disconnect it from AWS KMS. While the key store is disconnected, you cannot create or use the CMKs in the key store. But, you do not need to delete CMKs and you can reconnect a disconnected custom key store at any time.</p> <p>If the operation succeeds, it returns a JSON object with no properties.</p> <p>This operation is part of the <a href=\\\"https://docs.aws.amazon.com/kms/latest/developerguide/custom-key-store-overview.html\\\">Custom Key Store feature</a> feature in AWS KMS, which combines the convenience and extensive integration of AWS KMS with the isolation and control of a single-tenant key store.</p>\"\
    },\
    \"DeleteImportedKeyMaterial\":{\
      \"name\":\"DeleteImportedKeyMaterial\",\
      \"http\":{\
        \"method\":\"POST\",\
        \"requestUri\":\"/\"\
      },\
      \"input\":{\"shape\":\"DeleteImportedKeyMaterialRequest\"},\
      \"errors\":[\
        {\"shape\":\"InvalidArnException\"},\
        {\"shape\":\"UnsupportedOperationException\"},\
        {\"shape\":\"DependencyTimeoutException\"},\
        {\"shape\":\"NotFoundException\"},\
        {\"shape\":\"KMSInternalException\"},\
        {\"shape\":\"KMSInvalidStateException\"}\
      ],\
      \"documentation\":\"<p>Deletes key material that you previously imported. This operation makes the specified customer master key (CMK) unusable. For more information about importing key material into AWS KMS, see <a href=\\\"https://docs.aws.amazon.com/kms/latest/developerguide/importing-keys.html\\\">Importing Key Material</a> in the <i>AWS Key Management Service Developer Guide</i>. You cannot perform this operation on a CMK in a different AWS account.</p> <p>When the specified CMK is in the <code>PendingDeletion</code> state, this operation does not change the CMK's state. Otherwise, it changes the CMK's state to <code>PendingImport</code>.</p> <p>After you delete key material, you can use <a>ImportKeyMaterial</a> to reimport the same key material into the CMK.</p> <p>The result of this operation varies with the key state of the CMK. For details, see <a href=\\\"https://docs.aws.amazon.com/kms/latest/developerguide/key-state.html\\\">How Key State Affects Use of a Customer Master Key</a> in the <i>AWS Key Management Service Developer Guide</i>.</p>\"\
    },\
    \"DescribeCustomKeyStores\":{\
      \"name\":\"DescribeCustomKeyStores\",\
      \"http\":{\
        \"method\":\"POST\",\
        \"requestUri\":\"/\"\
      },\
      \"input\":{\"shape\":\"DescribeCustomKeyStoresRequest\"},\
      \"output\":{\"shape\":\"DescribeCustomKeyStoresResponse\"},\
      \"errors\":[\
        {\"shape\":\"CustomKeyStoreNotFoundException\"},\
        {\"shape\":\"KMSInternalException\"}\
      ],\
      \"documentation\":\"<p>Gets information about <a href=\\\"https://docs.aws.amazon.com/kms/latest/developerguide/custom-key-store-overview.html\\\">custom key stores</a> in the account and region.</p> <p>This operation is part of the <a href=\\\"https://docs.aws.amazon.com/kms/latest/developerguide/custom-key-store-overview.html\\\">Custom Key Store feature</a> feature in AWS KMS, which combines the convenience and extensive integration of AWS KMS with the isolation and control of a single-tenant key store.</p> <p>By default, this operation returns information about all custom key stores in the account and region. To get only information about a particular custom key store, use either the <code>CustomKeyStoreName</code> or <code>CustomKeyStoreId</code> parameter (but not both).</p> <p>To determine whether the custom key store is connected to its AWS CloudHSM cluster, use the <code>ConnectionState</code> element in the response. If an attempt to connect the custom key store failed, the <code>ConnectionState</code> value is <code>FAILED</code> and the <code>ConnectionErrorCode</code> element in the response indicates the cause of the failure. For help interpreting the <code>ConnectionErrorCode</code>, see <a>CustomKeyStoresListEntry</a>.</p> <p>Custom key stores have a <code>DISCONNECTED</code> connection state if the key store has never been connected or you use the <a>DisconnectCustomKeyStore</a> operation to disconnect it. If your custom key store state is <code>CONNECTED</code> but you are having trouble using it, make sure that its associated AWS CloudHSM cluster is active and contains the minimum number of HSMs required for the operation, if any.</p> <p> For help repairing your custom key store, see the <a href=\\\"https://docs.aws.amazon.com/kms/latest/developerguide/fix-keystore.html\\\">Troubleshooting Custom Key Stores</a> topic in the <i>AWS Key Management Service Developer Guide</i>.</p>\"\
    },\
    \"DescribeKey\":{\
      \"name\":\"DescribeKey\",\
      \"http\":{\
        \"method\":\"POST\",\
        \"requestUri\":\"/\"\
      },\
      \"input\":{\"shape\":\"DescribeKeyRequest\"},\
      \"output\":{\"shape\":\"DescribeKeyResponse\"},\
      \"errors\":[\
        {\"shape\":\"NotFoundException\"},\
        {\"shape\":\"InvalidArnException\"},\
        {\"shape\":\"DependencyTimeoutException\"},\
        {\"shape\":\"KMSInternalException\"}\
      ],\
      \"documentation\":\"<p>Provides detailed information about the specified customer master key (CMK).</p> <p>You can use <code>DescribeKey</code> on a predefined AWS alias, that is, an AWS alias with no key ID. When you do, AWS KMS associates the alias with an <a href=\\\"https://docs.aws.amazon.com/kms/latest/developerguide/concepts.html#master_keys\\\">AWS managed CMK</a> and returns its <code>KeyId</code> and <code>Arn</code> in the response.</p> <p>To perform this operation on a CMK in a different AWS account, specify the key ARN or alias ARN in the value of the KeyId parameter.</p>\"\
    },\
    \"DisableKey\":{\
      \"name\":\"DisableKey\",\
      \"http\":{\
        \"method\":\"POST\",\
        \"requestUri\":\"/\"\
      },\
      \"input\":{\"shape\":\"DisableKeyRequest\"},\
      \"errors\":[\
        {\"shape\":\"NotFoundException\"},\
        {\"shape\":\"InvalidArnException\"},\
        {\"shape\":\"DependencyTimeoutException\"},\
        {\"shape\":\"KMSInternalException\"},\
        {\"shape\":\"KMSInvalidStateException\"}\
      ],\
      \"documentation\":\"<p>Sets the state of a customer master key (CMK) to disabled, thereby preventing its use for cryptographic operations. You cannot perform this operation on a CMK in a different AWS account.</p> <p>For more information about how key state affects the use of a CMK, see <a href=\\\"https://docs.aws.amazon.com/kms/latest/developerguide/key-state.html\\\">How Key State Affects the Use of a Customer Master Key</a> in the <i> <i>AWS Key Management Service Developer Guide</i> </i>.</p> <p>The result of this operation varies with the key state of the CMK. For details, see <a href=\\\"https://docs.aws.amazon.com/kms/latest/developerguide/key-state.html\\\">How Key State Affects Use of a Customer Master Key</a> in the <i>AWS Key Management Service Developer Guide</i>.</p>\"\
    },\
    \"DisableKeyRotation\":{\
      \"name\":\"DisableKeyRotation\",\
      \"http\":{\
        \"method\":\"POST\",\
        \"requestUri\":\"/\"\
      },\
      \"input\":{\"shape\":\"DisableKeyRotationRequest\"},\
      \"errors\":[\
        {\"shape\":\"NotFoundException\"},\
        {\"shape\":\"DisabledException\"},\
        {\"shape\":\"InvalidArnException\"},\
        {\"shape\":\"DependencyTimeoutException\"},\
        {\"shape\":\"KMSInternalException\"},\
        {\"shape\":\"KMSInvalidStateException\"},\
        {\"shape\":\"UnsupportedOperationException\"}\
      ],\
      \"documentation\":\"<p>Disables <a href=\\\"https://docs.aws.amazon.com/kms/latest/developerguide/rotate-keys.html\\\">automatic rotation of the key material</a> for the specified customer master key (CMK). You cannot perform this operation on a CMK in a different AWS account.</p> <p>The result of this operation varies with the key state of the CMK. For details, see <a href=\\\"https://docs.aws.amazon.com/kms/latest/developerguide/key-state.html\\\">How Key State Affects Use of a Customer Master Key</a> in the <i>AWS Key Management Service Developer Guide</i>.</p>\"\
    },\
    \"DisconnectCustomKeyStore\":{\
      \"name\":\"DisconnectCustomKeyStore\",\
      \"http\":{\
        \"method\":\"POST\",\
        \"requestUri\":\"/\"\
      },\
      \"input\":{\"shape\":\"DisconnectCustomKeyStoreRequest\"},\
      \"output\":{\"shape\":\"DisconnectCustomKeyStoreResponse\"},\
      \"errors\":[\
        {\"shape\":\"CustomKeyStoreInvalidStateException\"},\
        {\"shape\":\"CustomKeyStoreNotFoundException\"},\
        {\"shape\":\"KMSInternalException\"}\
      ],\
      \"documentation\":\"<p>Disconnects the <a href=\\\"https://docs.aws.amazon.com/kms/latest/developerguide/custom-key-store-overview.html\\\">custom key store</a> from its associated AWS CloudHSM cluster. While a custom key store is disconnected, you can manage the custom key store and its customer master keys (CMKs), but you cannot create or use CMKs in the custom key store. You can reconnect the custom key store at any time.</p> <note> <p>While a custom key store is disconnected, all attempts to create customer master keys (CMKs) in the custom key store or to use existing CMKs in cryptographic operations will fail. This action can prevent users from storing and accessing sensitive data.</p> </note> <p/> <p>To find the connection state of a custom key store, use the <a>DescribeCustomKeyStores</a> operation. To reconnect a custom key store, use the <a>ConnectCustomKeyStore</a> operation.</p> <p>If the operation succeeds, it returns a JSON object with no properties.</p> <p>This operation is part of the <a href=\\\"https://docs.aws.amazon.com/kms/latest/developerguide/custom-key-store-overview.html\\\">Custom Key Store feature</a> feature in AWS KMS, which combines the convenience and extensive integration of AWS KMS with the isolation and control of a single-tenant key store.</p>\"\
    },\
    \"EnableKey\":{\
      \"name\":\"EnableKey\",\
      \"http\":{\
        \"method\":\"POST\",\
        \"requestUri\":\"/\"\
      },\
      \"input\":{\"shape\":\"EnableKeyRequest\"},\
      \"errors\":[\
        {\"shape\":\"NotFoundException\"},\
        {\"shape\":\"InvalidArnException\"},\
        {\"shape\":\"DependencyTimeoutException\"},\
        {\"shape\":\"KMSInternalException\"},\
        {\"shape\":\"LimitExceededException\"},\
        {\"shape\":\"KMSInvalidStateException\"}\
      ],\
      \"documentation\":\"<p>Sets the key state of a customer master key (CMK) to enabled. This allows you to use the CMK for cryptographic operations. You cannot perform this operation on a CMK in a different AWS account.</p> <p>The result of this operation varies with the key state of the CMK. For details, see <a href=\\\"https://docs.aws.amazon.com/kms/latest/developerguide/key-state.html\\\">How Key State Affects Use of a Customer Master Key</a> in the <i>AWS Key Management Service Developer Guide</i>.</p>\"\
    },\
    \"EnableKeyRotation\":{\
      \"name\":\"EnableKeyRotation\",\
      \"http\":{\
        \"method\":\"POST\",\
        \"requestUri\":\"/\"\
      },\
      \"input\":{\"shape\":\"EnableKeyRotationRequest\"},\
      \"errors\":[\
        {\"shape\":\"NotFoundException\"},\
        {\"shape\":\"DisabledException\"},\
        {\"shape\":\"InvalidArnException\"},\
        {\"shape\":\"DependencyTimeoutException\"},\
        {\"shape\":\"KMSInternalException\"},\
        {\"shape\":\"KMSInvalidStateException\"},\
        {\"shape\":\"UnsupportedOperationException\"}\
      ],\
      \"documentation\":\"<p>Enables <a href=\\\"https://docs.aws.amazon.com/kms/latest/developerguide/rotate-keys.html\\\">automatic rotation of the key material</a> for the specified customer master key (CMK). You cannot perform this operation on a CMK in a different AWS account.</p> <p>You cannot enable automatic rotation of CMKs with imported key material or CMKs in a <a href=\\\"https://docs.aws.amazon.com/kms/latest/developerguide/custom-key-store-overview.html\\\">custom key store</a>.</p> <p>The result of this operation varies with the key state of the CMK. For details, see <a href=\\\"https://docs.aws.amazon.com/kms/latest/developerguide/key-state.html\\\">How Key State Affects Use of a Customer Master Key</a> in the <i>AWS Key Management Service Developer Guide</i>.</p>\"\
    },\
    \"Encrypt\":{\
      \"name\":\"Encrypt\",\
      \"http\":{\
        \"method\":\"POST\",\
        \"requestUri\":\"/\"\
      },\
      \"input\":{\"shape\":\"EncryptRequest\"},\
      \"output\":{\"shape\":\"EncryptResponse\"},\
      \"errors\":[\
        {\"shape\":\"NotFoundException\"},\
        {\"shape\":\"DisabledException\"},\
        {\"shape\":\"KeyUnavailableException\"},\
        {\"shape\":\"DependencyTimeoutException\"},\
        {\"shape\":\"InvalidKeyUsageException\"},\
        {\"shape\":\"InvalidGrantTokenException\"},\
        {\"shape\":\"KMSInternalException\"},\
        {\"shape\":\"KMSInvalidStateException\"}\
      ],\
      \"documentation\":\"<p>Encrypts plaintext into ciphertext by using a customer master key (CMK). The <code>Encrypt</code> operation has two primary use cases:</p> <ul> <li> <p>You can encrypt up to 4 kilobytes (4096 bytes) of arbitrary data such as an RSA key, a database password, or other sensitive information.</p> </li> <li> <p>You can use the <code>Encrypt</code> operation to move encrypted data from one AWS region to another. In the first region, generate a data key and use the plaintext key to encrypt the data. Then, in the new region, call the <code>Encrypt</code> method on same plaintext data key. Now, you can safely move the encrypted data and encrypted data key to the new region, and decrypt in the new region when necessary.</p> </li> </ul> <p>You don't need use this operation to encrypt a data key within a region. The <a>GenerateDataKey</a> and <a>GenerateDataKeyWithoutPlaintext</a> operations return an encrypted data key.</p> <p>Also, you don't need to use this operation to encrypt data in your application. You can use the plaintext and encrypted data keys that the <code>GenerateDataKey</code> operation returns.</p> <p>The result of this operation varies with the key state of the CMK. For details, see <a href=\\\"https://docs.aws.amazon.com/kms/latest/developerguide/key-state.html\\\">How Key State Affects Use of a Customer Master Key</a> in the <i>AWS Key Management Service Developer Guide</i>.</p> <p>To perform this operation on a CMK in a different AWS account, specify the key ARN or alias ARN in the value of the KeyId parameter.</p>\"\
    },\
    \"GenerateDataKey\":{\
      \"name\":\"GenerateDataKey\",\
      \"http\":{\
        \"method\":\"POST\",\
        \"requestUri\":\"/\"\
      },\
      \"input\":{\"shape\":\"GenerateDataKeyRequest\"},\
      \"output\":{\"shape\":\"GenerateDataKeyResponse\"},\
      \"errors\":[\
        {\"shape\":\"NotFoundException\"},\
        {\"shape\":\"DisabledException\"},\
        {\"shape\":\"KeyUnavailableException\"},\
        {\"shape\":\"DependencyTimeoutException\"},\
        {\"shape\":\"InvalidKeyUsageException\"},\
        {\"shape\":\"InvalidGrantTokenException\"},\
        {\"shape\":\"KMSInternalException\"},\
        {\"shape\":\"KMSInvalidStateException\"}\
      ],\
      \"documentation\":\"<p>Generates a unique data key. This operation returns a plaintext copy of the data key and a copy that is encrypted under a customer master key (CMK) that you specify. You can use the plaintext key to encrypt your data outside of KMS and store the encrypted data key with the encrypted data.</p> <p> <code>GenerateDataKey</code> returns a unique data key for each request. The bytes in the key are not related to the caller or CMK that is used to encrypt the data key.</p> <p>To generate a data key, you need to specify the customer master key (CMK) that will be used to encrypt the data key. You must also specify the length of the data key using either the <code>KeySpec</code> or <code>NumberOfBytes</code> field (but not both). For common key lengths (128-bit and 256-bit symmetric keys), we recommend that you use <code>KeySpec</code>. To perform this operation on a CMK in a different AWS account, specify the key ARN or alias ARN in the value of the KeyId parameter.</p> <p>You will find the plaintext copy of the data key in the <code>Plaintext</code> field of the response, and the encrypted copy of the data key in the <code>CiphertextBlob</code> field.</p> <p>We recommend that you use the following pattern to encrypt data locally in your application:</p> <ol> <li> <p>Use the <code>GenerateDataKey</code> operation to get a data encryption key.</p> </li> <li> <p>Use the plaintext data key (returned in the <code>Plaintext</code> field of the response) to encrypt data locally, then erase the plaintext data key from memory.</p> </li> <li> <p>Store the encrypted data key (returned in the <code>CiphertextBlob</code> field of the response) alongside the locally encrypted data.</p> </li> </ol> <p>To decrypt data locally:</p> <ol> <li> <p>Use the <a>Decrypt</a> operation to decrypt the encrypted data key. The operation returns a plaintext copy of the data key.</p> </li> <li> <p>Use the plaintext data key to decrypt data locally, then erase the plaintext data key from memory.</p> </li> </ol> <p>To get only an encrypted copy of the data key, use <a>GenerateDataKeyWithoutPlaintext</a>. To get a cryptographically secure random byte string, use <a>GenerateRandom</a>.</p> <p>You can use the optional encryption context to add additional security to your encryption operation. When you specify an <code>EncryptionContext</code> in the <code>GenerateDataKey</code> operation, you must specify the same encryption context (a case-sensitive exact match) in your request to <a>Decrypt</a> the data key. Otherwise, the request to decrypt fails with an <code>InvalidCiphertextException</code>. For more information, see <a href=\\\"https://docs.aws.amazon.com/kms/latest/developerguide/concepts.html#encrypt_context\\\">Encryption Context</a> in the <i> <i>AWS Key Management Service Developer Guide</i> </i>.</p> <p>The result of this operation varies with the key state of the CMK. For details, see <a href=\\\"https://docs.aws.amazon.com/kms/latest/developerguide/key-state.html\\\">How Key State Affects Use of a Customer Master Key</a> in the <i>AWS Key Management Service Developer Guide</i>.</p>\"\
    },\
    \"GenerateDataKeyWithoutPlaintext\":{\
      \"name\":\"GenerateDataKeyWithoutPlaintext\",\
      \"http\":{\
        \"method\":\"POST\",\
        \"requestUri\":\"/\"\
      },\
      \"input\":{\"shape\":\"GenerateDataKeyWithoutPlaintextRequest\"},\
      \"output\":{\"shape\":\"GenerateDataKeyWithoutPlaintextResponse\"},\
      \"errors\":[\
        {\"shape\":\"NotFoundException\"},\
        {\"shape\":\"DisabledException\"},\
        {\"shape\":\"KeyUnavailableException\"},\
        {\"shape\":\"DependencyTimeoutException\"},\
        {\"shape\":\"InvalidKeyUsageException\"},\
        {\"shape\":\"InvalidGrantTokenException\"},\
        {\"shape\":\"KMSInternalException\"},\
        {\"shape\":\"KMSInvalidStateException\"}\
      ],\
      \"documentation\":\"<p>Generates a unique data key. This operation returns a data key that is encrypted under a customer master key (CMK) that you specify. <code>GenerateDataKeyWithoutPlaintext</code> is identical to <a>GenerateDataKey</a> except that returns only the encrypted copy of the data key.</p> <p>Like <code>GenerateDataKey</code>, <code>GenerateDataKeyWithoutPlaintext</code> returns a unique data key for each request. The bytes in the key are not related to the caller or CMK that is used to encrypt the data key.</p> <p>This operation is useful for systems that need to encrypt data at some point, but not immediately. When you need to encrypt the data, you call the <a>Decrypt</a> operation on the encrypted copy of the key.</p> <p>It's also useful in distributed systems with different levels of trust. For example, you might store encrypted data in containers. One component of your system creates new containers and stores an encrypted data key with each container. Then, a different component puts the data into the containers. That component first decrypts the data key, uses the plaintext data key to encrypt data, puts the encrypted data into the container, and then destroys the plaintext data key. In this system, the component that creates the containers never sees the plaintext data key.</p> <p>The result of this operation varies with the key state of the CMK. For details, see <a href=\\\"https://docs.aws.amazon.com/kms/latest/developerguide/key-state.html\\\">How Key State Affects Use of a Customer Master Key</a> in the <i>AWS Key Management Service Developer Guide</i>.</p>\"\
    },\
    \"GenerateRandom\":{\
      \"name\":\"GenerateRandom\",\
      \"http\":{\
        \"method\":\"POST\",\
        \"requestUri\":\"/\"\
      },\
      \"input\":{\"shape\":\"GenerateRandomRequest\"},\
      \"output\":{\"shape\":\"GenerateRandomResponse\"},\
      \"errors\":[\
        {\"shape\":\"DependencyTimeoutException\"},\
        {\"shape\":\"KMSInternalException\"},\
        {\"shape\":\"CustomKeyStoreNotFoundException\"},\
        {\"shape\":\"CustomKeyStoreInvalidStateException\"}\
      ],\
      \"documentation\":\"<p>Returns a random byte string that is cryptographically secure.</p> <p>By default, the random byte string is generated in AWS KMS. To generate the byte string in the AWS CloudHSM cluster that is associated with a <a href=\\\"https://docs.aws.amazon.com/kms/latest/developerguide/custom-key-store-overview.html\\\">custom key store</a>, specify the custom key store ID.</p> <p>For more information about entropy and random number generation, see the <a href=\\\"https://d0.awsstatic.com/whitepapers/KMS-Cryptographic-Details.pdf\\\">AWS Key Management Service Cryptographic Details</a> whitepaper.</p>\"\
    },\
    \"GetKeyPolicy\":{\
      \"name\":\"GetKeyPolicy\",\
      \"http\":{\
        \"method\":\"POST\",\
        \"requestUri\":\"/\"\
      },\
      \"input\":{\"shape\":\"GetKeyPolicyRequest\"},\
      \"output\":{\"shape\":\"GetKeyPolicyResponse\"},\
      \"errors\":[\
        {\"shape\":\"NotFoundException\"},\
        {\"shape\":\"InvalidArnException\"},\
        {\"shape\":\"DependencyTimeoutException\"},\
        {\"shape\":\"KMSInternalException\"},\
        {\"shape\":\"KMSInvalidStateException\"}\
      ],\
      \"documentation\":\"<p>Gets a key policy attached to the specified customer master key (CMK). You cannot perform this operation on a CMK in a different AWS account.</p>\"\
    },\
    \"GetKeyRotationStatus\":{\
      \"name\":\"GetKeyRotationStatus\",\
      \"http\":{\
        \"method\":\"POST\",\
        \"requestUri\":\"/\"\
      },\
      \"input\":{\"shape\":\"GetKeyRotationStatusRequest\"},\
      \"output\":{\"shape\":\"GetKeyRotationStatusResponse\"},\
      \"errors\":[\
        {\"shape\":\"NotFoundException\"},\
        {\"shape\":\"InvalidArnException\"},\
        {\"shape\":\"DependencyTimeoutException\"},\
        {\"shape\":\"KMSInternalException\"},\
        {\"shape\":\"KMSInvalidStateException\"},\
        {\"shape\":\"UnsupportedOperationException\"}\
      ],\
      \"documentation\":\"<p>Gets a Boolean value that indicates whether <a href=\\\"https://docs.aws.amazon.com/kms/latest/developerguide/rotate-keys.html\\\">automatic rotation of the key material</a> is enabled for the specified customer master key (CMK).</p> <p>The result of this operation varies with the key state of the CMK. For details, see <a href=\\\"https://docs.aws.amazon.com/kms/latest/developerguide/key-state.html\\\">How Key State Affects Use of a Customer Master Key</a> in the <i>AWS Key Management Service Developer Guide</i>.</p> <ul> <li> <p>Disabled: The key rotation status does not change when you disable a CMK. However, while the CMK is disabled, AWS KMS does not rotate the backing key.</p> </li> <li> <p>Pending deletion: While a CMK is pending deletion, its key rotation status is <code>false</code> and AWS KMS does not rotate the backing key. If you cancel the deletion, the original key rotation status is restored.</p> </li> </ul> <p>To perform this operation on a CMK in a different AWS account, specify the key ARN in the value of the <code>KeyId</code> parameter.</p>\"\
    },\
    \"GetParametersForImport\":{\
      \"name\":\"GetParametersForImport\",\
      \"http\":{\
        \"method\":\"POST\",\
        \"requestUri\":\"/\"\
      },\
      \"input\":{\"shape\":\"GetParametersForImportRequest\"},\
      \"output\":{\"shape\":\"GetParametersForImportResponse\"},\
      \"errors\":[\
        {\"shape\":\"InvalidArnException\"},\
        {\"shape\":\"UnsupportedOperationException\"},\
        {\"shape\":\"DependencyTimeoutException\"},\
        {\"shape\":\"NotFoundException\"},\
        {\"shape\":\"KMSInternalException\"},\
        {\"shape\":\"KMSInvalidStateException\"}\
      ],\
      \"documentation\":\"<p>Returns the items you need in order to import key material into AWS KMS from your existing key management infrastructure. For more information about importing key material into AWS KMS, see <a href=\\\"https://docs.aws.amazon.com/kms/latest/developerguide/importing-keys.html\\\">Importing Key Material</a> in the <i>AWS Key Management Service Developer Guide</i>.</p> <p>You must specify the key ID of the customer master key (CMK) into which you will import key material. This CMK's <code>Origin</code> must be <code>EXTERNAL</code>. You must also specify the wrapping algorithm and type of wrapping key (public key) that you will use to encrypt the key material. You cannot perform this operation on a CMK in a different AWS account.</p> <p>This operation returns a public key and an import token. Use the public key to encrypt the key material. Store the import token to send with a subsequent <a>ImportKeyMaterial</a> request. The public key and import token from the same response must be used together. These items are valid for 24 hours. When they expire, they cannot be used for a subsequent <a>ImportKeyMaterial</a> request. To get new ones, send another <code>GetParametersForImport</code> request.</p> <p>The result of this operation varies with the key state of the CMK. For details, see <a href=\\\"https://docs.aws.amazon.com/kms/latest/developerguide/key-state.html\\\">How Key State Affects Use of a Customer Master Key</a> in the <i>AWS Key Management Service Developer Guide</i>.</p>\"\
    },\
    \"ImportKeyMaterial\":{\
      \"name\":\"ImportKeyMaterial\",\
      \"http\":{\
        \"method\":\"POST\",\
        \"requestUri\":\"/\"\
      },\
      \"input\":{\"shape\":\"ImportKeyMaterialRequest\"},\
      \"output\":{\"shape\":\"ImportKeyMaterialResponse\"},\
      \"errors\":[\
        {\"shape\":\"InvalidArnException\"},\
        {\"shape\":\"UnsupportedOperationException\"},\
        {\"shape\":\"DependencyTimeoutException\"},\
        {\"shape\":\"NotFoundException\"},\
        {\"shape\":\"KMSInternalException\"},\
        {\"shape\":\"KMSInvalidStateException\"},\
        {\"shape\":\"InvalidCiphertextException\"},\
        {\"shape\":\"IncorrectKeyMaterialException\"},\
        {\"shape\":\"ExpiredImportTokenException\"},\
        {\"shape\":\"InvalidImportTokenException\"}\
      ],\
      \"documentation\":\"<p>Imports key material into an existing AWS KMS customer master key (CMK) that was created without key material. You cannot perform this operation on a CMK in a different AWS account. For more information about creating CMKs with no key material and then importing key material, see <a href=\\\"https://docs.aws.amazon.com/kms/latest/developerguide/importing-keys.html\\\">Importing Key Material</a> in the <i>AWS Key Management Service Developer Guide</i>.</p> <p>Before using this operation, call <a>GetParametersForImport</a>. Its response includes a public key and an import token. Use the public key to encrypt the key material. Then, submit the import token from the same <code>GetParametersForImport</code> response.</p> <p>When calling this operation, you must specify the following values:</p> <ul> <li> <p>The key ID or key ARN of a CMK with no key material. Its <code>Origin</code> must be <code>EXTERNAL</code>.</p> <p>To create a CMK with no key material, call <a>CreateKey</a> and set the value of its <code>Origin</code> parameter to <code>EXTERNAL</code>. To get the <code>Origin</code> of a CMK, call <a>DescribeKey</a>.)</p> </li> <li> <p>The encrypted key material. To get the public key to encrypt the key material, call <a>GetParametersForImport</a>.</p> </li> <li> <p>The import token that <a>GetParametersForImport</a> returned. This token and the public key used to encrypt the key material must have come from the same response.</p> </li> <li> <p>Whether the key material expires and if so, when. If you set an expiration date, you can change it only by reimporting the same key material and specifying a new expiration date. If the key material expires, AWS KMS deletes the key material and the CMK becomes unusable. To use the CMK again, you must reimport the same key material.</p> </li> </ul> <p>When this operation is successful, the key state of the CMK changes from <code>PendingImport</code> to <code>Enabled</code>, and you can use the CMK. After you successfully import key material into a CMK, you can reimport the same key material into that CMK, but you cannot import different key material.</p> <p>The result of this operation varies with the key state of the CMK. For details, see <a href=\\\"https://docs.aws.amazon.com/kms/latest/developerguide/key-state.html\\\">How Key State Affects Use of a Customer Master Key</a> in the <i>AWS Key Management Service Developer Guide</i>.</p>\"\
    },\
    \"ListAliases\":{\
      \"name\":\"ListAliases\",\
      \"http\":{\
        \"method\":\"POST\",\
        \"requestUri\":\"/\"\
      },\
      \"input\":{\"shape\":\"ListAliasesRequest\"},\
      \"output\":{\"shape\":\"ListAliasesResponse\"},\
      \"errors\":[\
        {\"shape\":\"DependencyTimeoutException\"},\
        {\"shape\":\"InvalidMarkerException\"},\
        {\"shape\":\"KMSInternalException\"},\
        {\"shape\":\"InvalidArnException\"},\
        {\"shape\":\"NotFoundException\"}\
      ],\
      \"documentation\":\"<p>Gets a list of aliases in the caller's AWS account and region. You cannot list aliases in other accounts. For more information about aliases, see <a>CreateAlias</a>.</p> <p>By default, the ListAliases command returns all aliases in the account and region. To get only the aliases that point to a particular customer master key (CMK), use the <code>KeyId</code> parameter.</p> <p>The <code>ListAliases</code> response can include aliases that you created and associated with your customer managed CMKs, and aliases that AWS created and associated with AWS managed CMKs in your account. You can recognize AWS aliases because their names have the format <code>aws/&lt;service-name&gt;</code>, such as <code>aws/dynamodb</code>.</p> <p>The response might also include aliases that have no <code>TargetKeyId</code> field. These are predefined aliases that AWS has created but has not yet associated with a CMK. Aliases that AWS creates in your account, including predefined aliases, do not count against your <a href=\\\"https://docs.aws.amazon.com/kms/latest/developerguide/limits.html#aliases-limit\\\">AWS KMS aliases limit</a>.</p>\"\
    },\
    \"ListGrants\":{\
      \"name\":\"ListGrants\",\
      \"http\":{\
        \"method\":\"POST\",\
        \"requestUri\":\"/\"\
      },\
      \"input\":{\"shape\":\"ListGrantsRequest\"},\
      \"output\":{\"shape\":\"ListGrantsResponse\"},\
      \"errors\":[\
        {\"shape\":\"NotFoundException\"},\
        {\"shape\":\"DependencyTimeoutException\"},\
        {\"shape\":\"InvalidMarkerException\"},\
        {\"shape\":\"InvalidArnException\"},\
        {\"shape\":\"KMSInternalException\"},\
        {\"shape\":\"KMSInvalidStateException\"}\
      ],\
      \"documentation\":\"<p>Gets a list of all grants for the specified customer master key (CMK).</p> <p>To perform this operation on a CMK in a different AWS account, specify the key ARN in the value of the <code>KeyId</code> parameter.</p>\"\
    },\
    \"ListKeyPolicies\":{\
      \"name\":\"ListKeyPolicies\",\
      \"http\":{\
        \"method\":\"POST\",\
        \"requestUri\":\"/\"\
      },\
      \"input\":{\"shape\":\"ListKeyPoliciesRequest\"},\
      \"output\":{\"shape\":\"ListKeyPoliciesResponse\"},\
      \"errors\":[\
        {\"shape\":\"NotFoundException\"},\
        {\"shape\":\"InvalidArnException\"},\
        {\"shape\":\"DependencyTimeoutException\"},\
        {\"shape\":\"KMSInternalException\"},\
        {\"shape\":\"KMSInvalidStateException\"}\
      ],\
      \"documentation\":\"<p>Gets the names of the key policies that are attached to a customer master key (CMK). This operation is designed to get policy names that you can use in a <a>GetKeyPolicy</a> operation. However, the only valid policy name is <code>default</code>. You cannot perform this operation on a CMK in a different AWS account.</p>\"\
    },\
    \"ListKeys\":{\
      \"name\":\"ListKeys\",\
      \"http\":{\
        \"method\":\"POST\",\
        \"requestUri\":\"/\"\
      },\
      \"input\":{\"shape\":\"ListKeysRequest\"},\
      \"output\":{\"shape\":\"ListKeysResponse\"},\
      \"errors\":[\
        {\"shape\":\"DependencyTimeoutException\"},\
        {\"shape\":\"KMSInternalException\"},\
        {\"shape\":\"InvalidMarkerException\"}\
      ],\
      \"documentation\":\"<p>Gets a list of all customer master keys (CMKs) in the caller's AWS account and region.</p>\"\
    },\
    \"ListResourceTags\":{\
      \"name\":\"ListResourceTags\",\
      \"http\":{\
        \"method\":\"POST\",\
        \"requestUri\":\"/\"\
      },\
      \"input\":{\"shape\":\"ListResourceTagsRequest\"},\
      \"output\":{\"shape\":\"ListResourceTagsResponse\"},\
      \"errors\":[\
        {\"shape\":\"KMSInternalException\"},\
        {\"shape\":\"NotFoundException\"},\
        {\"shape\":\"InvalidArnException\"},\
        {\"shape\":\"InvalidMarkerException\"}\
      ],\
      \"documentation\":\"<p>Returns a list of all tags for the specified customer master key (CMK).</p> <p>You cannot perform this operation on a CMK in a different AWS account.</p>\"\
    },\
    \"ListRetirableGrants\":{\
      \"name\":\"ListRetirableGrants\",\
      \"http\":{\
        \"method\":\"POST\",\
        \"requestUri\":\"/\"\
      },\
      \"input\":{\"shape\":\"ListRetirableGrantsRequest\"},\
      \"output\":{\"shape\":\"ListGrantsResponse\"},\
      \"errors\":[\
        {\"shape\":\"DependencyTimeoutException\"},\
        {\"shape\":\"InvalidMarkerException\"},\
        {\"shape\":\"InvalidArnException\"},\
        {\"shape\":\"NotFoundException\"},\
        {\"shape\":\"KMSInternalException\"}\
      ],\
      \"documentation\":\"<p>Returns a list of all grants for which the grant's <code>RetiringPrincipal</code> matches the one specified.</p> <p>A typical use is to list all grants that you are able to retire. To retire a grant, use <a>RetireGrant</a>.</p>\"\
    },\
    \"PutKeyPolicy\":{\
      \"name\":\"PutKeyPolicy\",\
      \"http\":{\
        \"method\":\"POST\",\
        \"requestUri\":\"/\"\
      },\
      \"input\":{\"shape\":\"PutKeyPolicyRequest\"},\
      \"errors\":[\
        {\"shape\":\"NotFoundException\"},\
        {\"shape\":\"InvalidArnException\"},\
        {\"shape\":\"MalformedPolicyDocumentException\"},\
        {\"shape\":\"DependencyTimeoutException\"},\
        {\"shape\":\"UnsupportedOperationException\"},\
        {\"shape\":\"KMSInternalException\"},\
        {\"shape\":\"LimitExceededException\"},\
        {\"shape\":\"KMSInvalidStateException\"}\
      ],\
      \"documentation\":\"<p>Attaches a key policy to the specified customer master key (CMK). You cannot perform this operation on a CMK in a different AWS account.</p> <p>For more information about key policies, see <a href=\\\"https://docs.aws.amazon.com/kms/latest/developerguide/key-policies.html\\\">Key Policies</a> in the <i>AWS Key Management Service Developer Guide</i>.</p>\"\
    },\
    \"ReEncrypt\":{\
      \"name\":\"ReEncrypt\",\
      \"http\":{\
        \"method\":\"POST\",\
        \"requestUri\":\"/\"\
      },\
      \"input\":{\"shape\":\"ReEncryptRequest\"},\
      \"output\":{\"shape\":\"ReEncryptResponse\"},\
      \"errors\":[\
        {\"shape\":\"NotFoundException\"},\
        {\"shape\":\"DisabledException\"},\
        {\"shape\":\"InvalidCiphertextException\"},\
        {\"shape\":\"KeyUnavailableException\"},\
        {\"shape\":\"DependencyTimeoutException\"},\
        {\"shape\":\"InvalidKeyUsageException\"},\
        {\"shape\":\"InvalidGrantTokenException\"},\
        {\"shape\":\"KMSInternalException\"},\
        {\"shape\":\"KMSInvalidStateException\"}\
      ],\
      \"documentation\":\"<p>Encrypts data on the server side with a new customer master key (CMK) without exposing the plaintext of the data on the client side. The data is first decrypted and then reencrypted. You can also use this operation to change the encryption context of a ciphertext. </p> <p>You can reencrypt data using CMKs in different AWS accounts.</p> <p>Unlike other operations, <code>ReEncrypt</code> is authorized twice, once as <code>ReEncryptFrom</code> on the source CMK and once as <code>ReEncryptTo</code> on the destination CMK. We recommend that you include the <code>\\\"kms:ReEncrypt*\\\"</code> permission in your <a href=\\\"https://docs.aws.amazon.com/kms/latest/developerguide/key-policies.html\\\">key policies</a> to permit reencryption from or to the CMK. This permission is automatically included in the key policy when you create a CMK through the console. But you must include it manually when you create a CMK programmatically or when you set a key policy with the <a>PutKeyPolicy</a> operation.</p> <p>The result of this operation varies with the key state of the CMK. For details, see <a href=\\\"https://docs.aws.amazon.com/kms/latest/developerguide/key-state.html\\\">How Key State Affects Use of a Customer Master Key</a> in the <i>AWS Key Management Service Developer Guide</i>.</p>\"\
    },\
    \"RetireGrant\":{\
      \"name\":\"RetireGrant\",\
      \"http\":{\
        \"method\":\"POST\",\
        \"requestUri\":\"/\"\
      },\
      \"input\":{\"shape\":\"RetireGrantRequest\"},\
      \"errors\":[\
        {\"shape\":\"InvalidArnException\"},\
        {\"shape\":\"InvalidGrantTokenException\"},\
        {\"shape\":\"InvalidGrantIdException\"},\
        {\"shape\":\"NotFoundException\"},\
        {\"shape\":\"DependencyTimeoutException\"},\
        {\"shape\":\"KMSInternalException\"},\
        {\"shape\":\"KMSInvalidStateException\"}\
      ],\
      \"documentation\":\"<p>Retires a grant. To clean up, you can retire a grant when you're done using it. You should revoke a grant when you intend to actively deny operations that depend on it. The following are permitted to call this API:</p> <ul> <li> <p>The AWS account (root user) under which the grant was created</p> </li> <li> <p>The <code>RetiringPrincipal</code>, if present in the grant</p> </li> <li> <p>The <code>GranteePrincipal</code>, if <code>RetireGrant</code> is an operation specified in the grant</p> </li> </ul> <p>You must identify the grant to retire by its grant token or by a combination of the grant ID and the Amazon Resource Name (ARN) of the customer master key (CMK). A grant token is a unique variable-length base64-encoded string. A grant ID is a 64 character unique identifier of a grant. The <a>CreateGrant</a> operation returns both.</p>\"\
    },\
    \"RevokeGrant\":{\
      \"name\":\"RevokeGrant\",\
      \"http\":{\
        \"method\":\"POST\",\
        \"requestUri\":\"/\"\
      },\
      \"input\":{\"shape\":\"RevokeGrantRequest\"},\
      \"errors\":[\
        {\"shape\":\"NotFoundException\"},\
        {\"shape\":\"DependencyTimeoutException\"},\
        {\"shape\":\"InvalidArnException\"},\
        {\"shape\":\"InvalidGrantIdException\"},\
        {\"shape\":\"KMSInternalException\"},\
        {\"shape\":\"KMSInvalidStateException\"}\
      ],\
      \"documentation\":\"<p>Revokes the specified grant for the specified customer master key (CMK). You can revoke a grant to actively deny operations that depend on it.</p> <p>To perform this operation on a CMK in a different AWS account, specify the key ARN in the value of the <code>KeyId</code> parameter.</p>\"\
    },\
    \"ScheduleKeyDeletion\":{\
      \"name\":\"ScheduleKeyDeletion\",\
      \"http\":{\
        \"method\":\"POST\",\
        \"requestUri\":\"/\"\
      },\
      \"input\":{\"shape\":\"ScheduleKeyDeletionRequest\"},\
      \"output\":{\"shape\":\"ScheduleKeyDeletionResponse\"},\
      \"errors\":[\
        {\"shape\":\"NotFoundException\"},\
        {\"shape\":\"InvalidArnException\"},\
        {\"shape\":\"DependencyTimeoutException\"},\
        {\"shape\":\"KMSInternalException\"},\
        {\"shape\":\"KMSInvalidStateException\"}\
      ],\
      \"documentation\":\"<p>Schedules the deletion of a customer master key (CMK). You may provide a waiting period, specified in days, before deletion occurs. If you do not provide a waiting period, the default period of 30 days is used. When this operation is successful, the key state of the CMK changes to <code>PendingDeletion</code>. Before the waiting period ends, you can use <a>CancelKeyDeletion</a> to cancel the deletion of the CMK. After the waiting period ends, AWS KMS deletes the CMK and all AWS KMS data associated with it, including all aliases that refer to it.</p> <important> <p>Deleting a CMK is a destructive and potentially dangerous operation. When a CMK is deleted, all data that was encrypted under the CMK is unrecoverable. To prevent the use of a CMK without deleting it, use <a>DisableKey</a>.</p> </important> <p>If you schedule deletion of a CMK from a <a href=\\\"https://docs.aws.amazon.com/kms/latest/developerguide/custom-key-store-overview.html\\\">custom key store</a>, when the waiting period expires, <code>ScheduleKeyDeletion</code> deletes the CMK from AWS KMS. Then AWS KMS makes a best effort to delete the key material from the associated AWS CloudHSM cluster. However, you might need to manually <a href=\\\"https://docs.aws.amazon.com/kms/latest/developerguide/fix-keystore.html#fix-keystore-orphaned-key\\\">delete the orphaned key material</a> from the cluster and its backups.</p> <p>You cannot perform this operation on a CMK in a different AWS account.</p> <p>For more information about scheduling a CMK for deletion, see <a href=\\\"https://docs.aws.amazon.com/kms/latest/developerguide/deleting-keys.html\\\">Deleting Customer Master Keys</a> in the <i>AWS Key Management Service Developer Guide</i>.</p> <p>The result of this operation varies with the key state of the CMK. For details, see <a href=\\\"https://docs.aws.amazon.com/kms/latest/developerguide/key-state.html\\\">How Key State Affects Use of a Customer Master Key</a> in the <i>AWS Key Management Service Developer Guide</i>.</p>\"\
    },\
    \"TagResource\":{\
      \"name\":\"TagResource\",\
      \"http\":{\
        \"method\":\"POST\",\
        \"requestUri\":\"/\"\
      },\
      \"input\":{\"shape\":\"TagResourceRequest\"},\
      \"errors\":[\
        {\"shape\":\"KMSInternalException\"},\
        {\"shape\":\"NotFoundException\"},\
        {\"shape\":\"InvalidArnException\"},\
        {\"shape\":\"KMSInvalidStateException\"},\
        {\"shape\":\"LimitExceededException\"},\
        {\"shape\":\"TagException\"}\
      ],\
      \"documentation\":\"<p>Adds or edits tags for a customer master key (CMK). You cannot perform this operation on a CMK in a different AWS account.</p> <p>Each tag consists of a tag key and a tag value. Tag keys and tag values are both required, but tag values can be empty (null) strings.</p> <p>You can only use a tag key once for each CMK. If you use the tag key again, AWS KMS replaces the current tag value with the specified value.</p> <p>For information about the rules that apply to tag keys and tag values, see <a href=\\\"https://docs.aws.amazon.com/awsaccountbilling/latest/aboutv2/allocation-tag-restrictions.html\\\">User-Defined Tag Restrictions</a> in the <i>AWS Billing and Cost Management User Guide</i>.</p> <p>The result of this operation varies with the key state of the CMK. For details, see <a href=\\\"https://docs.aws.amazon.com/kms/latest/developerguide/key-state.html\\\">How Key State Affects Use of a Customer Master Key</a> in the <i>AWS Key Management Service Developer Guide</i>.</p>\"\
    },\
    \"UntagResource\":{\
      \"name\":\"UntagResource\",\
      \"http\":{\
        \"method\":\"POST\",\
        \"requestUri\":\"/\"\
      },\
      \"input\":{\"shape\":\"UntagResourceRequest\"},\
      \"errors\":[\
        {\"shape\":\"KMSInternalException\"},\
        {\"shape\":\"NotFoundException\"},\
        {\"shape\":\"InvalidArnException\"},\
        {\"shape\":\"KMSInvalidStateException\"},\
        {\"shape\":\"TagException\"}\
      ],\
      \"documentation\":\"<p>Removes the specified tags from the specified customer master key (CMK). You cannot perform this operation on a CMK in a different AWS account.</p> <p>To remove a tag, specify the tag key. To change the tag value of an existing tag key, use <a>TagResource</a>.</p> <p>The result of this operation varies with the key state of the CMK. For details, see <a href=\\\"https://docs.aws.amazon.com/kms/latest/developerguide/key-state.html\\\">How Key State Affects Use of a Customer Master Key</a> in the <i>AWS Key Management Service Developer Guide</i>.</p>\"\
    },\
    \"UpdateAlias\":{\
      \"name\":\"UpdateAlias\",\
      \"http\":{\
        \"method\":\"POST\",\
        \"requestUri\":\"/\"\
      },\
      \"input\":{\"shape\":\"UpdateAliasRequest\"},\
      \"errors\":[\
        {\"shape\":\"DependencyTimeoutException\"},\
        {\"shape\":\"NotFoundException\"},\
        {\"shape\":\"KMSInternalException\"},\
        {\"shape\":\"KMSInvalidStateException\"}\
      ],\
      \"documentation\":\"<p>Associates an existing alias with a different customer master key (CMK). Each CMK can have multiple aliases, but the aliases must be unique within the account and region. You cannot perform this operation on an alias in a different AWS account.</p> <p>This operation works only on existing aliases. To change the alias of a CMK to a new value, use <a>CreateAlias</a> to create a new alias and <a>DeleteAlias</a> to delete the old alias.</p> <p>Because an alias is not a property of a CMK, you can create, update, and delete the aliases of a CMK without affecting the CMK. Also, aliases do not appear in the response from the <a>DescribeKey</a> operation. To get the aliases of all CMKs in the account, use the <a>ListAliases</a> operation. </p> <p>The alias name must begin with <code>alias/</code> followed by a name, such as <code>alias/ExampleAlias</code>. It can contain only alphanumeric characters, forward slashes (/), underscores (_), and dashes (-). The alias name cannot begin with <code>alias/aws/</code>. The <code>alias/aws/</code> prefix is reserved for <a href=\\\"https://docs.aws.amazon.com/kms/latest/developerguide/concepts.html#aws-managed-cmk\\\">AWS managed CMKs</a>. </p> <p>The result of this operation varies with the key state of the CMK. For details, see <a href=\\\"https://docs.aws.amazon.com/kms/latest/developerguide/key-state.html\\\">How Key State Affects Use of a Customer Master Key</a> in the <i>AWS Key Management Service Developer Guide</i>.</p>\"\
    },\
    \"UpdateCustomKeyStore\":{\
      \"name\":\"UpdateCustomKeyStore\",\
      \"http\":{\
        \"method\":\"POST\",\
        \"requestUri\":\"/\"\
      },\
      \"input\":{\"shape\":\"UpdateCustomKeyStoreRequest\"},\
      \"output\":{\"shape\":\"UpdateCustomKeyStoreResponse\"},\
      \"errors\":[\
        {\"shape\":\"CustomKeyStoreNotFoundException\"},\
        {\"shape\":\"CloudHsmClusterNotFoundException\"},\
        {\"shape\":\"CloudHsmClusterNotRelatedException\"},\
        {\"shape\":\"CustomKeyStoreInvalidStateException\"},\
        {\"shape\":\"KMSInternalException\"},\
        {\"shape\":\"CloudHsmClusterNotActiveException\"},\
        {\"shape\":\"CloudHsmClusterInvalidConfigurationException\"}\
      ],\
      \"documentation\":\"<p>Changes the properties of a custom key store. Use the <code>CustomKeyStoreId</code> parameter to identify the custom key store you want to edit. Use the remaining parameters to change the properties of the custom key store.</p> <p>You can only update a custom key store that is disconnected. To disconnect the custom key store, use <a>DisconnectCustomKeyStore</a>. To reconnect the custom key store after the update completes, use <a>ConnectCustomKeyStore</a>. To find the connection state of a custom key store, use the <a>DescribeCustomKeyStores</a> operation.</p> <p>Use the parameters of <code>UpdateCustomKeyStore</code> to edit your keystore settings.</p> <ul> <li> <p>Use the <b>NewCustomKeyStoreName</b> parameter to change the friendly name of the custom key store to the value that you specify.</p> <p> </p> </li> <li> <p>Use the <b>KeyStorePassword</b> parameter tell AWS KMS the current password of the <a href=\\\"https://docs.aws.amazon.com/kms/latest/developerguide/key-store-concepts.html#concept-kmsuser\\\"> <code>kmsuser</code> crypto user (CU)</a> in the associated AWS CloudHSM cluster. You can use this parameter to <a href=\\\"https://docs.aws.amazon.com/kms/latest/developerguide/fix-keystore.html#fix-keystore-password\\\">fix connection failures</a> that occur when AWS KMS cannot log into the associated cluster because the <code>kmsuser</code> password has changed. This value does not change the password in the AWS CloudHSM cluster.</p> <p> </p> </li> <li> <p>Use the <b>CloudHsmClusterId</b> parameter to associate the custom key store with a different, but related, AWS CloudHSM cluster. You can use this parameter to repair a custom key store if its AWS CloudHSM cluster becomes corrupted or is deleted, or when you need to create or restore a cluster from a backup. </p> </li> </ul> <p>If the operation succeeds, it returns a JSON object with no properties.</p> <p>This operation is part of the <a href=\\\"https://docs.aws.amazon.com/kms/latest/developerguide/custom-key-store-overview.html\\\">Custom Key Store feature</a> feature in AWS KMS, which combines the convenience and extensive integration of AWS KMS with the isolation and control of a single-tenant key store.</p>\"\
    },\
    \"UpdateKeyDescription\":{\
      \"name\":\"UpdateKeyDescription\",\
      \"http\":{\
        \"method\":\"POST\",\
        \"requestUri\":\"/\"\
      },\
      \"input\":{\"shape\":\"UpdateKeyDescriptionRequest\"},\
      \"errors\":[\
        {\"shape\":\"NotFoundException\"},\
        {\"shape\":\"InvalidArnException\"},\
        {\"shape\":\"DependencyTimeoutException\"},\
        {\"shape\":\"KMSInternalException\"},\
        {\"shape\":\"KMSInvalidStateException\"}\
      ],\
      \"documentation\":\"<p>Updates the description of a customer master key (CMK). To see the description of a CMK, use <a>DescribeKey</a>. </p> <p>You cannot perform this operation on a CMK in a different AWS account.</p> <p>The result of this operation varies with the key state of the CMK. For details, see <a href=\\\"https://docs.aws.amazon.com/kms/latest/developerguide/key-state.html\\\">How Key State Affects Use of a Customer Master Key</a> in the <i>AWS Key Management Service Developer Guide</i>.</p>\"\
    }\
  },\
  \"shapes\":{\
    \"AWSAccountIdType\":{\"type\":\"string\"},\
    \"AlgorithmSpec\":{\
      \"type\":\"string\",\
      \"enum\":[\
        \"RSAES_PKCS1_V1_5\",\
        \"RSAES_OAEP_SHA_1\",\
        \"RSAES_OAEP_SHA_256\"\
      ]\
    },\
    \"AliasList\":{\
      \"type\":\"list\",\
      \"member\":{\"shape\":\"AliasListEntry\"}\
    },\
    \"AliasListEntry\":{\
      \"type\":\"structure\",\
      \"members\":{\
        \"AliasName\":{\
          \"shape\":\"AliasNameType\",\
          \"documentation\":\"<p>String that contains the alias. This value begins with <code>alias/</code>.</p>\"\
        },\
        \"AliasArn\":{\
          \"shape\":\"ArnType\",\
          \"documentation\":\"<p>String that contains the key ARN.</p>\"\
        },\
        \"TargetKeyId\":{\
          \"shape\":\"KeyIdType\",\
          \"documentation\":\"<p>String that contains the key identifier referred to by the alias.</p>\"\
        }\
      },\
      \"documentation\":\"<p>Contains information about an alias.</p>\"\
    },\
    \"AliasNameType\":{\
      \"type\":\"string\",\
      \"max\":256,\
      \"min\":1,\
      \"pattern\":\"^[a-zA-Z0-9:/_-]+$\"\
    },\
    \"AlreadyExistsException\":{\
      \"type\":\"structure\",\
      \"members\":{\
        \"message\":{\"shape\":\"ErrorMessageType\"}\
      },\
      \"documentation\":\"<p>The request was rejected because it attempted to create a resource that already exists.</p>\",\
      \"exception\":true\
    },\
    \"ArnType\":{\
      \"type\":\"string\",\
      \"max\":2048,\
      \"min\":20\
    },\
    \"BooleanType\":{\"type\":\"boolean\"},\
    \"CancelKeyDeletionRequest\":{\
      \"type\":\"structure\",\
      \"required\":[\"KeyId\"],\
      \"members\":{\
        \"KeyId\":{\
          \"shape\":\"KeyIdType\",\
          \"documentation\":\"<p>The unique identifier for the customer master key (CMK) for which to cancel deletion.</p> <p>Specify the key ID or the Amazon Resource Name (ARN) of the CMK.</p> <p>For example:</p> <ul> <li> <p>Key ID: <code>1234abcd-12ab-34cd-56ef-1234567890ab</code> </p> </li> <li> <p>Key ARN: <code>arn:aws:kms:us-east-2:111122223333:key/1234abcd-12ab-34cd-56ef-1234567890ab</code> </p> </li> </ul> <p>To get the key ID and key ARN for a CMK, use <a>ListKeys</a> or <a>DescribeKey</a>.</p>\"\
        }\
      }\
    },\
    \"CancelKeyDeletionResponse\":{\
      \"type\":\"structure\",\
      \"members\":{\
        \"KeyId\":{\
          \"shape\":\"KeyIdType\",\
          \"documentation\":\"<p>The unique identifier of the master key for which deletion is canceled.</p>\"\
        }\
      }\
    },\
    \"CiphertextType\":{\
      \"type\":\"blob\",\
      \"max\":6144,\
      \"min\":1\
    },\
    \"CloudHsmClusterIdType\":{\
      \"type\":\"string\",\
      \"max\":24,\
      \"min\":19\
    },\
    \"CloudHsmClusterInUseException\":{\
      \"type\":\"structure\",\
      \"members\":{\
        \"message\":{\"shape\":\"ErrorMessageType\"}\
      },\
      \"documentation\":\"<p>The request was rejected because the specified AWS CloudHSM cluster is already associated with a custom key store or it shares a backup history with a cluster that is associated with a custom key store. Each custom key store must be associated with a different AWS CloudHSM cluster.</p> <p>Clusters that share a backup history have the same cluster certificate. To view the cluster certificate of a cluster, use the <a href=\\\"https://docs.aws.amazon.com/cloudhsm/latest/APIReference/API_DescribeClusters.html\\\">DescribeClusters</a> operation.</p>\",\
      \"exception\":true\
    },\
    \"CloudHsmClusterInvalidConfigurationException\":{\
      \"type\":\"structure\",\
      \"members\":{\
        \"message\":{\"shape\":\"ErrorMessageType\"}\
      },\
      \"documentation\":\"<p>The request was rejected because the associated AWS CloudHSM cluster did not meet the configuration requirements for a custom key store.</p> <ul> <li> <p>The cluster must be configured with private subnets in at least two different Availability Zones in the Region.</p> </li> <li> <p>The <a href=\\\"https://docs.aws.amazon.com/cloudhsm/latest/userguide/configure-sg.html\\\">security group for the cluster</a> (cloudhsm-cluster-<i>&lt;cluster-id&gt;</i>-sg) must include inbound rules and outbound rules that allow TCP traffic on ports 2223-2225. The <b>Source</b> in the inbound rules and the <b>Destination</b> in the outbound rules must match the security group ID. These rules are set by default when you create the cluster. Do not delete or change them. To get information about a particular security group, use the <a href=\\\"https://docs.aws.amazon.com/AWSEC2/latest/APIReference/API_DescribeSecurityGroups.html\\\">DescribeSecurityGroups</a> operation.</p> </li> <li> <p>The cluster must contain at least as many HSMs as the operation requires. To add HSMs, use the AWS CloudHSM <a href=\\\"https://docs.aws.amazon.com/cloudhsm/latest/APIReference/API_CreateHsm.html\\\">CreateHsm</a> operation.</p> <p>For the <a>CreateCustomKeyStore</a>, <a>UpdateCustomKeyStore</a>, and <a>CreateKey</a> operations, the AWS CloudHSM cluster must have at least two active HSMs, each in a different Availability Zone. For the <a>ConnectCustomKeyStore</a> operation, the AWS CloudHSM must contain at least one active HSM.</p> </li> </ul> <p>For information about the requirements for an AWS CloudHSM cluster that is associated with a custom key store, see <a href=\\\"https://docs.aws.amazon.com/kms/latest/developerguide/create-keystore.html#before-keystore\\\">Assemble the Prerequisites</a> in the <i>AWS Key Management Service Developer Guide</i>. For information about creating a private subnet for an AWS CloudHSM cluster, see <a href=\\\"https://docs.aws.amazon.com/cloudhsm/latest/userguide/create-subnets.html\\\">Create a Private Subnet</a> in the <i>AWS CloudHSM User Guide</i>. For information about cluster security groups, see <a href=\\\"https://docs.aws.amazon.com/cloudhsm/latest/userguide/configure-sg.html\\\">Configure a Default Security Group</a> in the <i> <i>AWS CloudHSM User Guide</i> </i>. </p>\",\
      \"exception\":true\
    },\
    \"CloudHsmClusterNotActiveException\":{\
      \"type\":\"structure\",\
      \"members\":{\
        \"message\":{\"shape\":\"ErrorMessageType\"}\
      },\
      \"documentation\":\"<p>The request was rejected because the AWS CloudHSM cluster that is associated with the custom key store is not active. Initialize and activate the cluster and try the command again. For detailed instructions, see <a href=\\\"https://docs.aws.amazon.com/cloudhsm/latest/userguide/getting-started.html\\\">Getting Started</a> in the <i>AWS CloudHSM User Guide</i>.</p>\",\
      \"exception\":true\
    },\
    \"CloudHsmClusterNotFoundException\":{\
      \"type\":\"structure\",\
      \"members\":{\
        \"message\":{\"shape\":\"ErrorMessageType\"}\
      },\
      \"documentation\":\"<p>The request was rejected because AWS KMS cannot find the AWS CloudHSM cluster with the specified cluster ID. Retry the request with a different cluster ID.</p>\",\
      \"exception\":true\
    },\
    \"CloudHsmClusterNotRelatedException\":{\
      \"type\":\"structure\",\
      \"members\":{\
        \"message\":{\"shape\":\"ErrorMessageType\"}\
      },\
      \"documentation\":\"<p>The request was rejected because the specified AWS CloudHSM cluster has a different cluster certificate than the original cluster. You cannot use the operation to specify an unrelated cluster.</p> <p>Specify a cluster that shares a backup history with the original cluster. This includes clusters that were created from a backup of the current cluster, and clusters that were created from the same backup that produced the current cluster.</p> <p>Clusters that share a backup history have the same cluster certificate. To view the cluster certificate of a cluster, use the <a href=\\\"https://docs.aws.amazon.com/cloudhsm/latest/APIReference/API_DescribeClusters.html\\\">DescribeClusters</a> operation.</p>\",\
      \"exception\":true\
    },\
    \"ConnectCustomKeyStoreRequest\":{\
      \"type\":\"structure\",\
      \"required\":[\"CustomKeyStoreId\"],\
      \"members\":{\
        \"CustomKeyStoreId\":{\
          \"shape\":\"CustomKeyStoreIdType\",\
          \"documentation\":\"<p>Enter the key store ID of the custom key store that you want to connect. To find the ID of a custom key store, use the <a>DescribeCustomKeyStores</a> operation.</p>\"\
        }\
      }\
    },\
    \"ConnectCustomKeyStoreResponse\":{\
      \"type\":\"structure\",\
      \"members\":{\
      }\
    },\
    \"ConnectionErrorCodeType\":{\
      \"type\":\"string\",\
      \"enum\":[\
        \"INVALID_CREDENTIALS\",\
        \"CLUSTER_NOT_FOUND\",\
        \"NETWORK_ERRORS\",\
        \"INTERNAL_ERROR\",\
        \"INSUFFICIENT_CLOUDHSM_HSMS\",\
        \"USER_LOCKED_OUT\"\
      ]\
    },\
    \"ConnectionStateType\":{\
      \"type\":\"string\",\
      \"enum\":[\
        \"CONNECTED\",\
        \"CONNECTING\",\
        \"FAILED\",\
        \"DISCONNECTED\",\
        \"DISCONNECTING\"\
      ]\
    },\
    \"CreateAliasRequest\":{\
      \"type\":\"structure\",\
      \"required\":[\
        \"AliasName\",\
        \"TargetKeyId\"\
      ],\
      \"members\":{\
        \"AliasName\":{\
          \"shape\":\"AliasNameType\",\
          \"documentation\":\"<p>Specifies the alias name. This value must begin with <code>alias/</code> followed by a name, such as <code>alias/ExampleAlias</code>. The alias name cannot begin with <code>alias/aws/</code>. The <code>alias/aws/</code> prefix is reserved for AWS managed CMKs.</p>\"\
        },\
        \"TargetKeyId\":{\
          \"shape\":\"KeyIdType\",\
          \"documentation\":\"<p>Identifies the CMK to which the alias refers. Specify the key ID or the Amazon Resource Name (ARN) of the CMK. You cannot specify another alias. For help finding the key ID and ARN, see <a href=\\\"https://docs.aws.amazon.com/kms/latest/developerguide/viewing-keys.html#find-cmk-id-arn\\\">Finding the Key ID and ARN</a> in the <i>AWS Key Management Service Developer Guide</i>.</p>\"\
        }\
      }\
    },\
    \"CreateCustomKeyStoreRequest\":{\
      \"type\":\"structure\",\
      \"required\":[\
        \"CustomKeyStoreName\",\
        \"CloudHsmClusterId\",\
        \"TrustAnchorCertificate\",\
        \"KeyStorePassword\"\
      ],\
      \"members\":{\
        \"CustomKeyStoreName\":{\
          \"shape\":\"CustomKeyStoreNameType\",\
          \"documentation\":\"<p>Specifies a friendly name for the custom key store. The name must be unique in your AWS account.</p>\"\
        },\
        \"CloudHsmClusterId\":{\
          \"shape\":\"CloudHsmClusterIdType\",\
          \"documentation\":\"<p>Identifies the AWS CloudHSM cluster for the custom key store. Enter the cluster ID of any active AWS CloudHSM cluster that is not already associated with a custom key store. To find the cluster ID, use the <a href=\\\"https://docs.aws.amazon.com/cloudhsm/latest/APIReference/API_DescribeClusters.html\\\">DescribeClusters</a> operation.</p>\"\
        },\
        \"TrustAnchorCertificate\":{\
          \"shape\":\"TrustAnchorCertificateType\",\
          \"documentation\":\"<p>Enter the content of the trust anchor certificate for the cluster. This is the content of the <code>customerCA.crt</code> file that you created when you <a href=\\\"https://docs.aws.amazon.com/cloudhsm/latest/userguide/initialize-cluster.html\\\">initialized the cluster</a>.</p>\"\
        },\
        \"KeyStorePassword\":{\
          \"shape\":\"KeyStorePasswordType\",\
          \"documentation\":\"<p>Enter the password of the <a href=\\\"https://docs.aws.amazon.com/kms/latest/developerguide/key-store-concepts.html#concept-kmsuser\\\"> <code>kmsuser</code> crypto user (CU) account</a> in the specified AWS CloudHSM cluster. AWS KMS logs into the cluster as this user to manage key material on your behalf.</p> <p>This parameter tells AWS KMS the <code>kmsuser</code> account password; it does not change the password in the AWS CloudHSM cluster.</p>\"\
        }\
      }\
    },\
    \"CreateCustomKeyStoreResponse\":{\
      \"type\":\"structure\",\
      \"members\":{\
        \"CustomKeyStoreId\":{\
          \"shape\":\"CustomKeyStoreIdType\",\
          \"documentation\":\"<p>A unique identifier for the new custom key store.</p>\"\
        }\
      }\
    },\
    \"CreateGrantRequest\":{\
      \"type\":\"structure\",\
      \"required\":[\
        \"KeyId\",\
        \"GranteePrincipal\",\
        \"Operations\"\
      ],\
      \"members\":{\
        \"KeyId\":{\
          \"shape\":\"KeyIdType\",\
          \"documentation\":\"<p>The unique identifier for the customer master key (CMK) that the grant applies to.</p> <p>Specify the key ID or the Amazon Resource Name (ARN) of the CMK. To specify a CMK in a different AWS account, you must use the key ARN.</p> <p>For example:</p> <ul> <li> <p>Key ID: <code>1234abcd-12ab-34cd-56ef-1234567890ab</code> </p> </li> <li> <p>Key ARN: <code>arn:aws:kms:us-east-2:111122223333:key/1234abcd-12ab-34cd-56ef-1234567890ab</code> </p> </li> </ul> <p>To get the key ID and key ARN for a CMK, use <a>ListKeys</a> or <a>DescribeKey</a>.</p>\"\
        },\
        \"GranteePrincipal\":{\
          \"shape\":\"PrincipalIdType\",\
          \"documentation\":\"<p>The principal that is given permission to perform the operations that the grant permits.</p> <p>To specify the principal, use the <a href=\\\"https://docs.aws.amazon.com/general/latest/gr/aws-arns-and-namespaces.html\\\">Amazon Resource Name (ARN)</a> of an AWS principal. Valid AWS principals include AWS accounts (root), IAM users, IAM roles, federated users, and assumed role users. For examples of the ARN syntax to use for specifying a principal, see <a href=\\\"https://docs.aws.amazon.com/general/latest/gr/aws-arns-and-namespaces.html#arn-syntax-iam\\\">AWS Identity and Access Management (IAM)</a> in the Example ARNs section of the <i>AWS General Reference</i>.</p>\"\
        },\
        \"RetiringPrincipal\":{\
          \"shape\":\"PrincipalIdType\",\
          \"documentation\":\"<p>The principal that is given permission to retire the grant by using <a>RetireGrant</a> operation.</p> <p>To specify the principal, use the <a href=\\\"https://docs.aws.amazon.com/general/latest/gr/aws-arns-and-namespaces.html\\\">Amazon Resource Name (ARN)</a> of an AWS principal. Valid AWS principals include AWS accounts (root), IAM users, federated users, and assumed role users. For examples of the ARN syntax to use for specifying a principal, see <a href=\\\"https://docs.aws.amazon.com/general/latest/gr/aws-arns-and-namespaces.html#arn-syntax-iam\\\">AWS Identity and Access Management (IAM)</a> in the Example ARNs section of the <i>AWS General Reference</i>.</p>\"\
        },\
        \"Operations\":{\
          \"shape\":\"GrantOperationList\",\
          \"documentation\":\"<p>A list of operations that the grant permits.</p>\"\
        },\
        \"Constraints\":{\
          \"shape\":\"GrantConstraints\",\
          \"documentation\":\"<p>Allows a cryptographic operation only when the encryption context matches or includes the encryption context specified in this structure. For more information about encryption context, see <a href=\\\"https://docs.aws.amazon.com/kms/latest/developerguide/concepts.html#encrypt_context\\\">Encryption Context</a> in the <i> <i>AWS Key Management Service Developer Guide</i> </i>.</p>\"\
        },\
        \"GrantTokens\":{\
          \"shape\":\"GrantTokenList\",\
          \"documentation\":\"<p>A list of grant tokens.</p> <p>For more information, see <a href=\\\"https://docs.aws.amazon.com/kms/latest/developerguide/concepts.html#grant_token\\\">Grant Tokens</a> in the <i>AWS Key Management Service Developer Guide</i>.</p>\"\
        },\
        \"Name\":{\
          \"shape\":\"GrantNameType\",\
          \"documentation\":\"<p>A friendly name for identifying the grant. Use this value to prevent the unintended creation of duplicate grants when retrying this request.</p> <p>When this value is absent, all <code>CreateGrant</code> requests result in a new grant with a unique <code>GrantId</code> even if all the supplied parameters are identical. This can result in unintended duplicates when you retry the <code>CreateGrant</code> request.</p> <p>When this value is present, you can retry a <code>CreateGrant</code> request with identical parameters; if the grant already exists, the original <code>GrantId</code> is returned without creating a new grant. Note that the returned grant token is unique with every <code>CreateGrant</code> request, even when a duplicate <code>GrantId</code> is returned. All grant tokens obtained in this way can be used interchangeably.</p>\"\
        }\
      }\
    },\
    \"CreateGrantResponse\":{\
      \"type\":\"structure\",\
      \"members\":{\
        \"GrantToken\":{\
          \"shape\":\"GrantTokenType\",\
          \"documentation\":\"<p>The grant token.</p> <p>For more information, see <a href=\\\"https://docs.aws.amazon.com/kms/latest/developerguide/concepts.html#grant_token\\\">Grant Tokens</a> in the <i>AWS Key Management Service Developer Guide</i>.</p>\"\
        },\
        \"GrantId\":{\
          \"shape\":\"GrantIdType\",\
          \"documentation\":\"<p>The unique identifier for the grant.</p> <p>You can use the <code>GrantId</code> in a subsequent <a>RetireGrant</a> or <a>RevokeGrant</a> operation.</p>\"\
        }\
      }\
    },\
    \"CreateKeyRequest\":{\
      \"type\":\"structure\",\
      \"members\":{\
        \"Policy\":{\
          \"shape\":\"PolicyType\",\
          \"documentation\":\"<p>The key policy to attach to the CMK.</p> <p>If you provide a key policy, it must meet the following criteria:</p> <ul> <li> <p>If you don't set <code>BypassPolicyLockoutSafetyCheck</code> to true, the key policy must allow the principal that is making the <code>CreateKey</code> request to make a subsequent <a>PutKeyPolicy</a> request on the CMK. This reduces the risk that the CMK becomes unmanageable. For more information, refer to the scenario in the <a href=\\\"https://docs.aws.amazon.com/kms/latest/developerguide/key-policies.html#key-policy-default-allow-root-enable-iam\\\">Default Key Policy</a> section of the <i> <i>AWS Key Management Service Developer Guide</i> </i>.</p> </li> <li> <p>Each statement in the key policy must contain one or more principals. The principals in the key policy must exist and be visible to AWS KMS. When you create a new AWS principal (for example, an IAM user or role), you might need to enforce a delay before including the new principal in a key policy because the new principal might not be immediately visible to AWS KMS. For more information, see <a href=\\\"https://docs.aws.amazon.com/IAM/latest/UserGuide/troubleshoot_general.html#troubleshoot_general_eventual-consistency\\\">Changes that I make are not always immediately visible</a> in the <i>AWS Identity and Access Management User Guide</i>.</p> </li> </ul> <p>If you do not provide a key policy, AWS KMS attaches a default key policy to the CMK. For more information, see <a href=\\\"https://docs.aws.amazon.com/kms/latest/developerguide/key-policies.html#key-policy-default\\\">Default Key Policy</a> in the <i>AWS Key Management Service Developer Guide</i>.</p> <p>The key policy size limit is 32 kilobytes (32768 bytes).</p>\"\
        },\
        \"Description\":{\
          \"shape\":\"DescriptionType\",\
          \"documentation\":\"<p>A description of the CMK.</p> <p>Use a description that helps you decide whether the CMK is appropriate for a task.</p>\"\
        },\
        \"KeyUsage\":{\
          \"shape\":\"KeyUsageType\",\
          \"documentation\":\"<p>The cryptographic operations for which you can use the CMK. The only valid value is <code>ENCRYPT_DECRYPT</code>, which means you can use the CMK to encrypt and decrypt data.</p>\"\
        },\
        \"Origin\":{\
          \"shape\":\"OriginType\",\
          \"documentation\":\"<p>The source of the key material for the CMK. You cannot change the origin after you create the CMK.</p> <p>The default is <code>AWS_KMS</code>, which means AWS KMS creates the key material in its own key store.</p> <p>When the parameter value is <code>EXTERNAL</code>, AWS KMS creates a CMK without key material so that you can import key material from your existing key management infrastructure. For more information about importing key material into AWS KMS, see <a href=\\\"https://docs.aws.amazon.com/kms/latest/developerguide/importing-keys.html\\\">Importing Key Material</a> in the <i>AWS Key Management Service Developer Guide</i>.</p> <p>When the parameter value is <code>AWS_CLOUDHSM</code>, AWS KMS creates the CMK in an AWS KMS <a href=\\\"https://docs.aws.amazon.com/kms/latest/developerguide/custom-key-store-overview.html\\\">custom key store</a> and creates its key material in the associated AWS CloudHSM cluster. You must also use the <code>CustomKeyStoreId</code> parameter to identify the custom key store.</p>\"\
        },\
        \"CustomKeyStoreId\":{\
          \"shape\":\"CustomKeyStoreIdType\",\
          \"documentation\":\"<p>Creates the CMK in the specified <a href=\\\"https://docs.aws.amazon.com/kms/latest/developerguide/custom-key-store-overview.html\\\">custom key store</a> and the key material in its associated AWS CloudHSM cluster. To create a CMK in a custom key store, you must also specify the <code>Origin</code> parameter with a value of <code>AWS_CLOUDHSM</code>. The AWS CloudHSM cluster that is associated with the custom key store must have at least two active HSMs, each in a different Availability Zone in the Region.</p> <p>To find the ID of a custom key store, use the <a>DescribeCustomKeyStores</a> operation.</p> <p>The response includes the custom key store ID and the ID of the AWS CloudHSM cluster.</p> <p>This operation is part of the <a href=\\\"https://docs.aws.amazon.com/kms/latest/developerguide/custom-key-store-overview.html\\\">Custom Key Store feature</a> feature in AWS KMS, which combines the convenience and extensive integration of AWS KMS with the isolation and control of a single-tenant key store.</p>\"\
        },\
        \"BypassPolicyLockoutSafetyCheck\":{\
          \"shape\":\"BooleanType\",\
          \"documentation\":\"<p>A flag to indicate whether to bypass the key policy lockout safety check.</p> <important> <p>Setting this value to true increases the risk that the CMK becomes unmanageable. Do not set this value to true indiscriminately.</p> <p>For more information, refer to the scenario in the <a href=\\\"https://docs.aws.amazon.com/kms/latest/developerguide/key-policies.html#key-policy-default-allow-root-enable-iam\\\">Default Key Policy</a> section in the <i> <i>AWS Key Management Service Developer Guide</i> </i>.</p> </important> <p>Use this parameter only when you include a policy in the request and you intend to prevent the principal that is making the request from making a subsequent <a>PutKeyPolicy</a> request on the CMK.</p> <p>The default value is false.</p>\"\
        },\
        \"Tags\":{\
          \"shape\":\"TagList\",\
          \"documentation\":\"<p>One or more tags. Each tag consists of a tag key and a tag value. Tag keys and tag values are both required, but tag values can be empty (null) strings.</p> <p>Use this parameter to tag the CMK when it is created. Alternately, you can omit this parameter and instead tag the CMK after it is created using <a>TagResource</a>.</p>\"\
        }\
      }\
    },\
    \"CreateKeyResponse\":{\
      \"type\":\"structure\",\
      \"members\":{\
        \"KeyMetadata\":{\
          \"shape\":\"KeyMetadata\",\
          \"documentation\":\"<p>Metadata associated with the CMK.</p>\"\
        }\
      }\
    },\
    \"CustomKeyStoreHasCMKsException\":{\
      \"type\":\"structure\",\
      \"members\":{\
        \"message\":{\"shape\":\"ErrorMessageType\"}\
      },\
      \"documentation\":\"<p>The request was rejected because the custom key store contains AWS KMS customer master keys (CMKs). After verifying that you do not need to use the CMKs, use the <a>ScheduleKeyDeletion</a> operation to delete the CMKs. After they are deleted, you can delete the custom key store.</p>\",\
      \"exception\":true\
    },\
    \"CustomKeyStoreIdType\":{\
      \"type\":\"string\",\
      \"max\":64,\
      \"min\":1\
    },\
    \"CustomKeyStoreInvalidStateException\":{\
      \"type\":\"structure\",\
      \"members\":{\
        \"message\":{\"shape\":\"ErrorMessageType\"}\
      },\
      \"documentation\":\"<p>The request was rejected because of the <code>ConnectionState</code> of the custom key store. To get the <code>ConnectionState</code> of a custom key store, use the <a>DescribeCustomKeyStores</a> operation.</p> <p>This exception is thrown under the following conditions:</p> <ul> <li> <p>You requested the <a>CreateKey</a> or <a>GenerateRandom</a> operation in a custom key store that is not connected. These operations are valid only when the custom key store <code>ConnectionState</code> is <code>CONNECTED</code>.</p> </li> <li> <p>You requested the <a>UpdateCustomKeyStore</a> or <a>DeleteCustomKeyStore</a> operation on a custom key store that is not disconnected. This operation is valid only when the custom key store <code>ConnectionState</code> is <code>DISCONNECTED</code>.</p> </li> <li> <p>You requested the <a>ConnectCustomKeyStore</a> operation on a custom key store with a <code>ConnectionState</code> of <code>DISCONNECTING</code> or <code>FAILED</code>. This operation is valid for all other <code>ConnectionState</code> values.</p> </li> </ul>\",\
      \"exception\":true\
    },\
    \"CustomKeyStoreNameInUseException\":{\
      \"type\":\"structure\",\
      \"members\":{\
        \"message\":{\"shape\":\"ErrorMessageType\"}\
      },\
      \"documentation\":\"<p>The request was rejected because the specified custom key store name is already assigned to another custom key store in the account. Try again with a custom key store name that is unique in the account.</p>\",\
      \"exception\":true\
    },\
    \"CustomKeyStoreNameType\":{\
      \"type\":\"string\",\
      \"max\":256,\
      \"min\":1\
    },\
    \"CustomKeyStoreNotFoundException\":{\
      \"type\":\"structure\",\
      \"members\":{\
        \"message\":{\"shape\":\"ErrorMessageType\"}\
      },\
      \"documentation\":\"<p>The request was rejected because AWS KMS cannot find a custom key store with the specified key store name or ID.</p>\",\
      \"exception\":true\
    },\
    \"CustomKeyStoresList\":{\
      \"type\":\"list\",\
      \"member\":{\"shape\":\"CustomKeyStoresListEntry\"}\
    },\
    \"CustomKeyStoresListEntry\":{\
      \"type\":\"structure\",\
      \"members\":{\
        \"CustomKeyStoreId\":{\
          \"shape\":\"CustomKeyStoreIdType\",\
          \"documentation\":\"<p>A unique identifier for the custom key store.</p>\"\
        },\
        \"CustomKeyStoreName\":{\
          \"shape\":\"CustomKeyStoreNameType\",\
          \"documentation\":\"<p>The user-specified friendly name for the custom key store.</p>\"\
        },\
        \"CloudHsmClusterId\":{\
          \"shape\":\"CloudHsmClusterIdType\",\
          \"documentation\":\"<p>A unique identifier for the AWS CloudHSM cluster that is associated with the custom key store.</p>\"\
        },\
        \"TrustAnchorCertificate\":{\
          \"shape\":\"TrustAnchorCertificateType\",\
          \"documentation\":\"<p>The trust anchor certificate of the associated AWS CloudHSM cluster. When you <a href=\\\"https://docs.aws.amazon.com/cloudhsm/latest/userguide/initialize-cluster.html#sign-csr\\\">initialize the cluster</a>, you create this certificate and save it in the <code>customerCA.crt</code> file.</p>\"\
        },\
        \"ConnectionState\":{\
          \"shape\":\"ConnectionStateType\",\
          \"documentation\":\"<p>Indicates whether the custom key store is connected to its AWS CloudHSM cluster.</p> <p>You can create and use CMKs in your custom key stores only when its connection state is <code>CONNECTED</code>.</p> <p>The value is <code>DISCONNECTED</code> if the key store has never been connected or you use the <a>DisconnectCustomKeyStore</a> operation to disconnect it. If the value is <code>CONNECTED</code> but you are having trouble using the custom key store, make sure that its associated AWS CloudHSM cluster is active and contains at least one active HSM.</p> <p>A value of <code>FAILED</code> indicates that an attempt to connect was unsuccessful. For help resolving a connection failure, see <a href=\\\"https://docs.aws.amazon.com/kms/latest/developerguide/fix-keystore.html\\\">Troubleshooting a Custom Key Store</a> in the <i>AWS Key Management Service Developer Guide</i>.</p>\"\
        },\
        \"ConnectionErrorCode\":{\
          \"shape\":\"ConnectionErrorCodeType\",\
          \"documentation\":\"<p>Describes the connection error. Valid values are:</p> <ul> <li> <p> <code>CLUSTER_NOT_FOUND</code> - AWS KMS cannot find the AWS CloudHSM cluster with the specified cluster ID.</p> </li> <li> <p> <code>INSUFFICIENT_CLOUDHSM_HSMS</code> - The associated AWS CloudHSM cluster does not contain any active HSMs. To connect a custom key store to its AWS CloudHSM cluster, the cluster must contain at least one active HSM.</p> </li> <li> <p> <code>INTERNAL_ERROR</code> - AWS KMS could not complete the request due to an internal error. Retry the request. For <code>ConnectCustomKeyStore</code> requests, disconnect the custom key store before trying to connect again.</p> </li> <li> <p> <code>INVALID_CREDENTIALS</code> - AWS KMS does not have the correct password for the <code>kmsuser</code> crypto user in the AWS CloudHSM cluster.</p> </li> <li> <p> <code>NETWORK_ERRORS</code> - Network errors are preventing AWS KMS from connecting to the custom key store.</p> </li> <li> <p> <code>USER_LOCKED_OUT</code> - The <code>kmsuser</code> CU account is locked out of the associated AWS CloudHSM cluster due to too many failed password attempts. Before you can connect your custom key store to its AWS CloudHSM cluster, you must change the <code>kmsuser</code> account password and update the password value for the custom key store.</p> </li> </ul> <p>For help with connection failures, see <a href=\\\"https://docs.aws.amazon.com/kms/latest/developerguide/fix-keystore.html\\\">Troubleshooting Custom Key Stores</a> in the <i>AWS Key Management Service Developer Guide</i>.</p>\"\
        },\
        \"CreationDate\":{\
          \"shape\":\"DateType\",\
          \"documentation\":\"<p>The date and time when the custom key store was created.</p>\"\
        }\
      },\
      \"documentation\":\"<p>Contains information about each custom key store in the custom key store list.</p>\"\
    },\
    \"DataKeySpec\":{\
      \"type\":\"string\",\
      \"enum\":[\
        \"AES_256\",\
        \"AES_128\"\
      ]\
    },\
    \"DateType\":{\"type\":\"timestamp\"},\
    \"DecryptRequest\":{\
      \"type\":\"structure\",\
      \"required\":[\"CiphertextBlob\"],\
      \"members\":{\
        \"CiphertextBlob\":{\
          \"shape\":\"CiphertextType\",\
          \"documentation\":\"<p>Ciphertext to be decrypted. The blob includes metadata.</p>\"\
        },\
        \"EncryptionContext\":{\
          \"shape\":\"EncryptionContextType\",\
          \"documentation\":\"<p>The encryption context. If this was specified in the <a>Encrypt</a> function, it must be specified here or the decryption operation will fail. For more information, see <a href=\\\"https://docs.aws.amazon.com/kms/latest/developerguide/concepts.html#encrypt_context\\\">Encryption Context</a>.</p>\"\
        },\
        \"GrantTokens\":{\
          \"shape\":\"GrantTokenList\",\
          \"documentation\":\"<p>A list of grant tokens.</p> <p>For more information, see <a href=\\\"https://docs.aws.amazon.com/kms/latest/developerguide/concepts.html#grant_token\\\">Grant Tokens</a> in the <i>AWS Key Management Service Developer Guide</i>.</p>\"\
        }\
      }\
    },\
    \"DecryptResponse\":{\
      \"type\":\"structure\",\
      \"members\":{\
        \"KeyId\":{\
          \"shape\":\"KeyIdType\",\
          \"documentation\":\"<p>ARN of the key used to perform the decryption. This value is returned if no errors are encountered during the operation.</p>\"\
        },\
        \"Plaintext\":{\
          \"shape\":\"PlaintextType\",\
          \"documentation\":\"<p>Decrypted plaintext data. When you use the HTTP API or the AWS CLI, the value is Base64-encoded. Otherwise, it is not encoded.</p>\"\
        }\
      }\
    },\
    \"DeleteAliasRequest\":{\
      \"type\":\"structure\",\
      \"required\":[\"AliasName\"],\
      \"members\":{\
        \"AliasName\":{\
          \"shape\":\"AliasNameType\",\
          \"documentation\":\"<p>The alias to be deleted. The alias name must begin with <code>alias/</code> followed by the alias name, such as <code>alias/ExampleAlias</code>.</p>\"\
        }\
      }\
    },\
    \"DeleteCustomKeyStoreRequest\":{\
      \"type\":\"structure\",\
      \"required\":[\"CustomKeyStoreId\"],\
      \"members\":{\
        \"CustomKeyStoreId\":{\
          \"shape\":\"CustomKeyStoreIdType\",\
          \"documentation\":\"<p>Enter the ID of the custom key store you want to delete. To find the ID of a custom key store, use the <a>DescribeCustomKeyStores</a> operation.</p>\"\
        }\
      }\
    },\
    \"DeleteCustomKeyStoreResponse\":{\
      \"type\":\"structure\",\
      \"members\":{\
      }\
    },\
    \"DeleteImportedKeyMaterialRequest\":{\
      \"type\":\"structure\",\
      \"required\":[\"KeyId\"],\
      \"members\":{\
        \"KeyId\":{\
          \"shape\":\"KeyIdType\",\
          \"documentation\":\"<p>Identifies the CMK from which you are deleting imported key material. The <code>Origin</code> of the CMK must be <code>EXTERNAL</code>.</p> <p>Specify the key ID or the Amazon Resource Name (ARN) of the CMK.</p> <p>For example:</p> <ul> <li> <p>Key ID: <code>1234abcd-12ab-34cd-56ef-1234567890ab</code> </p> </li> <li> <p>Key ARN: <code>arn:aws:kms:us-east-2:111122223333:key/1234abcd-12ab-34cd-56ef-1234567890ab</code> </p> </li> </ul> <p>To get the key ID and key ARN for a CMK, use <a>ListKeys</a> or <a>DescribeKey</a>.</p>\"\
        }\
      }\
    },\
    \"DependencyTimeoutException\":{\
      \"type\":\"structure\",\
      \"members\":{\
        \"message\":{\"shape\":\"ErrorMessageType\"}\
      },\
      \"documentation\":\"<p>The system timed out while trying to fulfill the request. The request can be retried.</p>\",\
      \"exception\":true,\
      \"fault\":true\
    },\
    \"DescribeCustomKeyStoresRequest\":{\
      \"type\":\"structure\",\
      \"members\":{\
        \"CustomKeyStoreId\":{\
          \"shape\":\"CustomKeyStoreIdType\",\
          \"documentation\":\"<p>Gets only information about the specified custom key store. Enter the key store ID.</p> <p>By default, this operation gets information about all custom key stores in the account and region. To limit the output to a particular custom key store, you can use either the <code>CustomKeyStoreId</code> or <code>CustomKeyStoreName</code> parameter, but not both.</p>\"\
        },\
        \"CustomKeyStoreName\":{\
          \"shape\":\"CustomKeyStoreNameType\",\
          \"documentation\":\"<p>Gets only information about the specified custom key store. Enter the friendly name of the custom key store.</p> <p>By default, this operation gets information about all custom key stores in the account and region. To limit the output to a particular custom key store, you can use either the <code>CustomKeyStoreId</code> or <code>CustomKeyStoreName</code> parameter, but not both.</p>\"\
        },\
        \"Limit\":{\
          \"shape\":\"LimitType\",\
          \"documentation\":\"<p>Use this parameter to specify the maximum number of items to return. When this value is present, AWS KMS does not return more than the specified number of items, but it might return fewer.</p>\"\
        },\
        \"Marker\":{\
          \"shape\":\"MarkerType\",\
          \"documentation\":\"<p>Use this parameter in a subsequent request after you receive a response with truncated results. Set it to the value of <code>NextMarker</code> from the truncated response you just received.</p>\"\
        }\
      }\
    },\
    \"DescribeCustomKeyStoresResponse\":{\
      \"type\":\"structure\",\
      \"members\":{\
        \"CustomKeyStores\":{\
          \"shape\":\"CustomKeyStoresList\",\
          \"documentation\":\"<p>Contains metadata about each custom key store.</p>\"\
        },\
        \"NextMarker\":{\
          \"shape\":\"MarkerType\",\
          \"documentation\":\"<p>When <code>Truncated</code> is true, this element is present and contains the value to use for the <code>Marker</code> parameter in a subsequent request.</p>\"\
        },\
        \"Truncated\":{\
          \"shape\":\"BooleanType\",\
          \"documentation\":\"<p>A flag that indicates whether there are more items in the list. When this value is true, the list in this response is truncated. To get more items, pass the value of the <code>NextMarker</code> element in thisresponse to the <code>Marker</code> parameter in a subsequent request.</p>\"\
        }\
      }\
    },\
    \"DescribeKeyRequest\":{\
      \"type\":\"structure\",\
      \"required\":[\"KeyId\"],\
      \"members\":{\
        \"KeyId\":{\
          \"shape\":\"KeyIdType\",\
          \"documentation\":\"<p>Describes the specified customer master key (CMK). </p> <p>If you specify a predefined AWS alias (an AWS alias with no key ID), KMS associates the alias with an <a href=\\\"https://docs.aws.amazon.com/kms/latest/developerguide/concepts.html#master_keys\\\">AWS managed CMK</a> and returns its <code>KeyId</code> and <code>Arn</code> in the response.</p> <p>To specify a CMK, use its key ID, Amazon Resource Name (ARN), alias name, or alias ARN. When using an alias name, prefix it with <code>\\\"alias/\\\"</code>. To specify a CMK in a different AWS account, you must use the key ARN or alias ARN.</p> <p>For example:</p> <ul> <li> <p>Key ID: <code>1234abcd-12ab-34cd-56ef-1234567890ab</code> </p> </li> <li> <p>Key ARN: <code>arn:aws:kms:us-east-2:111122223333:key/1234abcd-12ab-34cd-56ef-1234567890ab</code> </p> </li> <li> <p>Alias name: <code>alias/ExampleAlias</code> </p> </li> <li> <p>Alias ARN: <code>arn:aws:kms:us-east-2:111122223333:alias/ExampleAlias</code> </p> </li> </ul> <p>To get the key ID and key ARN for a CMK, use <a>ListKeys</a> or <a>DescribeKey</a>. To get the alias name and alias ARN, use <a>ListAliases</a>.</p>\"\
        },\
        \"GrantTokens\":{\
          \"shape\":\"GrantTokenList\",\
          \"documentation\":\"<p>A list of grant tokens.</p> <p>For more information, see <a href=\\\"https://docs.aws.amazon.com/kms/latest/developerguide/concepts.html#grant_token\\\">Grant Tokens</a> in the <i>AWS Key Management Service Developer Guide</i>.</p>\"\
        }\
      }\
    },\
    \"DescribeKeyResponse\":{\
      \"type\":\"structure\",\
      \"members\":{\
        \"KeyMetadata\":{\
          \"shape\":\"KeyMetadata\",\
          \"documentation\":\"<p>Metadata associated with the key.</p>\"\
        }\
      }\
    },\
    \"DescriptionType\":{\
      \"type\":\"string\",\
      \"max\":8192,\
      \"min\":0\
    },\
    \"DisableKeyRequest\":{\
      \"type\":\"structure\",\
      \"required\":[\"KeyId\"],\
      \"members\":{\
        \"KeyId\":{\
          \"shape\":\"KeyIdType\",\
          \"documentation\":\"<p>A unique identifier for the customer master key (CMK).</p> <p>Specify the key ID or the Amazon Resource Name (ARN) of the CMK.</p> <p>For example:</p> <ul> <li> <p>Key ID: <code>1234abcd-12ab-34cd-56ef-1234567890ab</code> </p> </li> <li> <p>Key ARN: <code>arn:aws:kms:us-east-2:111122223333:key/1234abcd-12ab-34cd-56ef-1234567890ab</code> </p> </li> </ul> <p>To get the key ID and key ARN for a CMK, use <a>ListKeys</a> or <a>DescribeKey</a>.</p>\"\
        }\
      }\
    },\
    \"DisableKeyRotationRequest\":{\
      \"type\":\"structure\",\
      \"required\":[\"KeyId\"],\
      \"members\":{\
        \"KeyId\":{\
          \"shape\":\"KeyIdType\",\
          \"documentation\":\"<p>A unique identifier for the customer master key (CMK).</p> <p>Specify the key ID or the Amazon Resource Name (ARN) of the CMK.</p> <p>For example:</p> <ul> <li> <p>Key ID: <code>1234abcd-12ab-34cd-56ef-1234567890ab</code> </p> </li> <li> <p>Key ARN: <code>arn:aws:kms:us-east-2:111122223333:key/1234abcd-12ab-34cd-56ef-1234567890ab</code> </p> </li> </ul> <p>To get the key ID and key ARN for a CMK, use <a>ListKeys</a> or <a>DescribeKey</a>.</p>\"\
        }\
      }\
    },\
    \"DisabledException\":{\
      \"type\":\"structure\",\
      \"members\":{\
        \"message\":{\"shape\":\"ErrorMessageType\"}\
      },\
      \"documentation\":\"<p>The request was rejected because the specified CMK is not enabled.</p>\",\
      \"exception\":true\
    },\
    \"DisconnectCustomKeyStoreRequest\":{\
      \"type\":\"structure\",\
      \"required\":[\"CustomKeyStoreId\"],\
      \"members\":{\
        \"CustomKeyStoreId\":{\
          \"shape\":\"CustomKeyStoreIdType\",\
          \"documentation\":\"<p>Enter the ID of the custom key store you want to disconnect. To find the ID of a custom key store, use the <a>DescribeCustomKeyStores</a> operation.</p>\"\
        }\
      }\
    },\
    \"DisconnectCustomKeyStoreResponse\":{\
      \"type\":\"structure\",\
      \"members\":{\
      }\
    },\
    \"EnableKeyRequest\":{\
      \"type\":\"structure\",\
      \"required\":[\"KeyId\"],\
      \"members\":{\
        \"KeyId\":{\
          \"shape\":\"KeyIdType\",\
          \"documentation\":\"<p>A unique identifier for the customer master key (CMK).</p> <p>Specify the key ID or the Amazon Resource Name (ARN) of the CMK.</p> <p>For example:</p> <ul> <li> <p>Key ID: <code>1234abcd-12ab-34cd-56ef-1234567890ab</code> </p> </li> <li> <p>Key ARN: <code>arn:aws:kms:us-east-2:111122223333:key/1234abcd-12ab-34cd-56ef-1234567890ab</code> </p> </li> </ul> <p>To get the key ID and key ARN for a CMK, use <a>ListKeys</a> or <a>DescribeKey</a>.</p>\"\
        }\
      }\
    },\
    \"EnableKeyRotationRequest\":{\
      \"type\":\"structure\",\
      \"required\":[\"KeyId\"],\
      \"members\":{\
        \"KeyId\":{\
          \"shape\":\"KeyIdType\",\
          \"documentation\":\"<p>A unique identifier for the customer master key (CMK).</p> <p>Specify the key ID or the Amazon Resource Name (ARN) of the CMK.</p> <p>For example:</p> <ul> <li> <p>Key ID: <code>1234abcd-12ab-34cd-56ef-1234567890ab</code> </p> </li> <li> <p>Key ARN: <code>arn:aws:kms:us-east-2:111122223333:key/1234abcd-12ab-34cd-56ef-1234567890ab</code> </p> </li> </ul> <p>To get the key ID and key ARN for a CMK, use <a>ListKeys</a> or <a>DescribeKey</a>.</p>\"\
        }\
      }\
    },\
    \"EncryptRequest\":{\
      \"type\":\"structure\",\
      \"required\":[\
        \"KeyId\",\
        \"Plaintext\"\
      ],\
      \"members\":{\
        \"KeyId\":{\
          \"shape\":\"KeyIdType\",\
          \"documentation\":\"<p>A unique identifier for the customer master key (CMK).</p> <p>To specify a CMK, use its key ID, Amazon Resource Name (ARN), alias name, or alias ARN. When using an alias name, prefix it with <code>\\\"alias/\\\"</code>. To specify a CMK in a different AWS account, you must use the key ARN or alias ARN.</p> <p>For example:</p> <ul> <li> <p>Key ID: <code>1234abcd-12ab-34cd-56ef-1234567890ab</code> </p> </li> <li> <p>Key ARN: <code>arn:aws:kms:us-east-2:111122223333:key/1234abcd-12ab-34cd-56ef-1234567890ab</code> </p> </li> <li> <p>Alias name: <code>alias/ExampleAlias</code> </p> </li> <li> <p>Alias ARN: <code>arn:aws:kms:us-east-2:111122223333:alias/ExampleAlias</code> </p> </li> </ul> <p>To get the key ID and key ARN for a CMK, use <a>ListKeys</a> or <a>DescribeKey</a>. To get the alias name and alias ARN, use <a>ListAliases</a>.</p>\"\
        },\
        \"Plaintext\":{\
          \"shape\":\"PlaintextType\",\
          \"documentation\":\"<p>Data to be encrypted.</p>\"\
        },\
        \"EncryptionContext\":{\
          \"shape\":\"EncryptionContextType\",\
          \"documentation\":\"<p>Name-value pair that specifies the encryption context to be used for authenticated encryption. If used here, the same value must be supplied to the <code>Decrypt</code> API or decryption will fail. For more information, see <a href=\\\"https://docs.aws.amazon.com/kms/latest/developerguide/concepts.html#encrypt_context\\\">Encryption Context</a>.</p>\"\
        },\
        \"GrantTokens\":{\
          \"shape\":\"GrantTokenList\",\
          \"documentation\":\"<p>A list of grant tokens.</p> <p>For more information, see <a href=\\\"https://docs.aws.amazon.com/kms/latest/developerguide/concepts.html#grant_token\\\">Grant Tokens</a> in the <i>AWS Key Management Service Developer Guide</i>.</p>\"\
        }\
      }\
    },\
    \"EncryptResponse\":{\
      \"type\":\"structure\",\
      \"members\":{\
        \"CiphertextBlob\":{\
          \"shape\":\"CiphertextType\",\
          \"documentation\":\"<p>The encrypted plaintext. When you use the HTTP API or the AWS CLI, the value is Base64-encoded. Otherwise, it is not encoded.</p>\"\
        },\
        \"KeyId\":{\
          \"shape\":\"KeyIdType\",\
          \"documentation\":\"<p>The ID of the key used during encryption.</p>\"\
        }\
      }\
    },\
    \"EncryptionContextKey\":{\"type\":\"string\"},\
    \"EncryptionContextType\":{\
      \"type\":\"map\",\
      \"key\":{\"shape\":\"EncryptionContextKey\"},\
      \"value\":{\"shape\":\"EncryptionContextValue\"}\
    },\
    \"EncryptionContextValue\":{\"type\":\"string\"},\
    \"ErrorMessageType\":{\"type\":\"string\"},\
    \"ExpirationModelType\":{\
      \"type\":\"string\",\
      \"enum\":[\
        \"KEY_MATERIAL_EXPIRES\",\
        \"KEY_MATERIAL_DOES_NOT_EXPIRE\"\
      ]\
    },\
    \"ExpiredImportTokenException\":{\
      \"type\":\"structure\",\
      \"members\":{\
        \"message\":{\"shape\":\"ErrorMessageType\"}\
      },\
      \"documentation\":\"<p>The request was rejected because the provided import token is expired. Use <a>GetParametersForImport</a> to get a new import token and public key, use the new public key to encrypt the key material, and then try the request again.</p>\",\
      \"exception\":true\
    },\
    \"GenerateDataKeyRequest\":{\
      \"type\":\"structure\",\
      \"required\":[\"KeyId\"],\
      \"members\":{\
        \"KeyId\":{\
          \"shape\":\"KeyIdType\",\
          \"documentation\":\"<p>An identifier for the CMK that encrypts the data key.</p> <p>To specify a CMK, use its key ID, Amazon Resource Name (ARN), alias name, or alias ARN. When using an alias name, prefix it with <code>\\\"alias/\\\"</code>. To specify a CMK in a different AWS account, you must use the key ARN or alias ARN.</p> <p>For example:</p> <ul> <li> <p>Key ID: <code>1234abcd-12ab-34cd-56ef-1234567890ab</code> </p> </li> <li> <p>Key ARN: <code>arn:aws:kms:us-east-2:111122223333:key/1234abcd-12ab-34cd-56ef-1234567890ab</code> </p> </li> <li> <p>Alias name: <code>alias/ExampleAlias</code> </p> </li> <li> <p>Alias ARN: <code>arn:aws:kms:us-east-2:111122223333:alias/ExampleAlias</code> </p> </li> </ul> <p>To get the key ID and key ARN for a CMK, use <a>ListKeys</a> or <a>DescribeKey</a>. To get the alias name and alias ARN, use <a>ListAliases</a>.</p>\"\
        },\
        \"EncryptionContext\":{\
          \"shape\":\"EncryptionContextType\",\
          \"documentation\":\"<p>A set of key-value pairs that represents additional authenticated data.</p> <p>For more information, see <a href=\\\"https://docs.aws.amazon.com/kms/latest/developerguide/concepts.html#encrypt_context\\\">Encryption Context</a> in the <i>AWS Key Management Service Developer Guide</i>.</p>\"\
        },\
        \"NumberOfBytes\":{\
          \"shape\":\"NumberOfBytesType\",\
          \"documentation\":\"<p>The length of the data key in bytes. For example, use the value 64 to generate a 512-bit data key (64 bytes is 512 bits). For common key lengths (128-bit and 256-bit symmetric keys), we recommend that you use the <code>KeySpec</code> field instead of this one.</p>\"\
        },\
        \"KeySpec\":{\
          \"shape\":\"DataKeySpec\",\
          \"documentation\":\"<p>The length of the data key. Use <code>AES_128</code> to generate a 128-bit symmetric key, or <code>AES_256</code> to generate a 256-bit symmetric key.</p>\"\
        },\
        \"GrantTokens\":{\
          \"shape\":\"GrantTokenList\",\
          \"documentation\":\"<p>A list of grant tokens.</p> <p>For more information, see <a href=\\\"https://docs.aws.amazon.com/kms/latest/developerguide/concepts.html#grant_token\\\">Grant Tokens</a> in the <i>AWS Key Management Service Developer Guide</i>.</p>\"\
        }\
      }\
    },\
    \"GenerateDataKeyResponse\":{\
      \"type\":\"structure\",\
      \"members\":{\
        \"CiphertextBlob\":{\
          \"shape\":\"CiphertextType\",\
          \"documentation\":\"<p>The encrypted copy of the data key. When you use the HTTP API or the AWS CLI, the value is Base64-encoded. Otherwise, it is not encoded.</p>\"\
        },\
        \"Plaintext\":{\
          \"shape\":\"PlaintextType\",\
          \"documentation\":\"<p>The plaintext data key. When you use the HTTP API or the AWS CLI, the value is Base64-encoded. Otherwise, it is not encoded. Use this data key to encrypt your data outside of KMS. Then, remove it from memory as soon as possible.</p>\"\
        },\
        \"KeyId\":{\
          \"shape\":\"KeyIdType\",\
          \"documentation\":\"<p>The identifier of the CMK that encrypted the data key.</p>\"\
        }\
      }\
    },\
    \"GenerateDataKeyWithoutPlaintextRequest\":{\
      \"type\":\"structure\",\
      \"required\":[\"KeyId\"],\
      \"members\":{\
        \"KeyId\":{\
          \"shape\":\"KeyIdType\",\
          \"documentation\":\"<p>The identifier of the customer master key (CMK) that encrypts the data key.</p> <p>To specify a CMK, use its key ID, Amazon Resource Name (ARN), alias name, or alias ARN. When using an alias name, prefix it with <code>\\\"alias/\\\"</code>. To specify a CMK in a different AWS account, you must use the key ARN or alias ARN.</p> <p>For example:</p> <ul> <li> <p>Key ID: <code>1234abcd-12ab-34cd-56ef-1234567890ab</code> </p> </li> <li> <p>Key ARN: <code>arn:aws:kms:us-east-2:111122223333:key/1234abcd-12ab-34cd-56ef-1234567890ab</code> </p> </li> <li> <p>Alias name: <code>alias/ExampleAlias</code> </p> </li> <li> <p>Alias ARN: <code>arn:aws:kms:us-east-2:111122223333:alias/ExampleAlias</code> </p> </li> </ul> <p>To get the key ID and key ARN for a CMK, use <a>ListKeys</a> or <a>DescribeKey</a>. To get the alias name and alias ARN, use <a>ListAliases</a>.</p>\"\
        },\
        \"EncryptionContext\":{\
          \"shape\":\"EncryptionContextType\",\
          \"documentation\":\"<p>A set of key-value pairs that represents additional authenticated data.</p> <p>For more information, see <a href=\\\"https://docs.aws.amazon.com/kms/latest/developerguide/concepts.html#encrypt_context\\\">Encryption Context</a> in the <i>AWS Key Management Service Developer Guide</i>.</p>\"\
        },\
        \"KeySpec\":{\
          \"shape\":\"DataKeySpec\",\
          \"documentation\":\"<p>The length of the data key. Use <code>AES_128</code> to generate a 128-bit symmetric key, or <code>AES_256</code> to generate a 256-bit symmetric key.</p>\"\
        },\
        \"NumberOfBytes\":{\
          \"shape\":\"NumberOfBytesType\",\
          \"documentation\":\"<p>The length of the data key in bytes. For example, use the value 64 to generate a 512-bit data key (64 bytes is 512 bits). For common key lengths (128-bit and 256-bit symmetric keys), we recommend that you use the <code>KeySpec</code> field instead of this one.</p>\"\
        },\
        \"GrantTokens\":{\
          \"shape\":\"GrantTokenList\",\
          \"documentation\":\"<p>A list of grant tokens.</p> <p>For more information, see <a href=\\\"https://docs.aws.amazon.com/kms/latest/developerguide/concepts.html#grant_token\\\">Grant Tokens</a> in the <i>AWS Key Management Service Developer Guide</i>.</p>\"\
        }\
      }\
    },\
    \"GenerateDataKeyWithoutPlaintextResponse\":{\
      \"type\":\"structure\",\
      \"members\":{\
        \"CiphertextBlob\":{\
          \"shape\":\"CiphertextType\",\
          \"documentation\":\"<p>The encrypted data key. When you use the HTTP API or the AWS CLI, the value is Base64-encoded. Otherwise, it is not encoded.</p>\"\
        },\
        \"KeyId\":{\
          \"shape\":\"KeyIdType\",\
          \"documentation\":\"<p>The identifier of the CMK that encrypted the data key.</p>\"\
        }\
      }\
    },\
    \"GenerateRandomRequest\":{\
      \"type\":\"structure\",\
      \"members\":{\
        \"NumberOfBytes\":{\
          \"shape\":\"NumberOfBytesType\",\
          \"documentation\":\"<p>The length of the byte string.</p>\"\
        },\
        \"CustomKeyStoreId\":{\
          \"shape\":\"CustomKeyStoreIdType\",\
          \"documentation\":\"<p>Generates the random byte string in the AWS CloudHSM cluster that is associated with the specified <a href=\\\"https://docs.aws.amazon.com/kms/latest/developerguide/custom-key-store-overview.html\\\">custom key store</a>. To find the ID of a custom key store, use the <a>DescribeCustomKeyStores</a> operation.</p>\"\
        }\
      }\
    },\
    \"GenerateRandomResponse\":{\
      \"type\":\"structure\",\
      \"members\":{\
        \"Plaintext\":{\
          \"shape\":\"PlaintextType\",\
          \"documentation\":\"<p>The random byte string. When you use the HTTP API or the AWS CLI, the value is Base64-encoded. Otherwise, it is not encoded.</p>\"\
        }\
      }\
    },\
    \"GetKeyPolicyRequest\":{\
      \"type\":\"structure\",\
      \"required\":[\
        \"KeyId\",\
        \"PolicyName\"\
      ],\
      \"members\":{\
        \"KeyId\":{\
          \"shape\":\"KeyIdType\",\
          \"documentation\":\"<p>A unique identifier for the customer master key (CMK).</p> <p>Specify the key ID or the Amazon Resource Name (ARN) of the CMK.</p> <p>For example:</p> <ul> <li> <p>Key ID: <code>1234abcd-12ab-34cd-56ef-1234567890ab</code> </p> </li> <li> <p>Key ARN: <code>arn:aws:kms:us-east-2:111122223333:key/1234abcd-12ab-34cd-56ef-1234567890ab</code> </p> </li> </ul> <p>To get the key ID and key ARN for a CMK, use <a>ListKeys</a> or <a>DescribeKey</a>.</p>\"\
        },\
        \"PolicyName\":{\
          \"shape\":\"PolicyNameType\",\
          \"documentation\":\"<p>Specifies the name of the key policy. The only valid name is <code>default</code>. To get the names of key policies, use <a>ListKeyPolicies</a>.</p>\"\
        }\
      }\
    },\
    \"GetKeyPolicyResponse\":{\
      \"type\":\"structure\",\
      \"members\":{\
        \"Policy\":{\
          \"shape\":\"PolicyType\",\
          \"documentation\":\"<p>A key policy document in JSON format.</p>\"\
        }\
      }\
    },\
    \"GetKeyRotationStatusRequest\":{\
      \"type\":\"structure\",\
      \"required\":[\"KeyId\"],\
      \"members\":{\
        \"KeyId\":{\
          \"shape\":\"KeyIdType\",\
          \"documentation\":\"<p>A unique identifier for the customer master key (CMK).</p> <p>Specify the key ID or the Amazon Resource Name (ARN) of the CMK. To specify a CMK in a different AWS account, you must use the key ARN.</p> <p>For example:</p> <ul> <li> <p>Key ID: <code>1234abcd-12ab-34cd-56ef-1234567890ab</code> </p> </li> <li> <p>Key ARN: <code>arn:aws:kms:us-east-2:111122223333:key/1234abcd-12ab-34cd-56ef-1234567890ab</code> </p> </li> </ul> <p>To get the key ID and key ARN for a CMK, use <a>ListKeys</a> or <a>DescribeKey</a>.</p>\"\
        }\
      }\
    },\
    \"GetKeyRotationStatusResponse\":{\
      \"type\":\"structure\",\
      \"members\":{\
        \"KeyRotationEnabled\":{\
          \"shape\":\"BooleanType\",\
          \"documentation\":\"<p>A Boolean value that specifies whether key rotation is enabled.</p>\"\
        }\
      }\
    },\
    \"GetParametersForImportRequest\":{\
      \"type\":\"structure\",\
      \"required\":[\
        \"KeyId\",\
        \"WrappingAlgorithm\",\
        \"WrappingKeySpec\"\
      ],\
      \"members\":{\
        \"KeyId\":{\
          \"shape\":\"KeyIdType\",\
          \"documentation\":\"<p>The identifier of the CMK into which you will import key material. The CMK's <code>Origin</code> must be <code>EXTERNAL</code>.</p> <p>Specify the key ID or the Amazon Resource Name (ARN) of the CMK.</p> <p>For example:</p> <ul> <li> <p>Key ID: <code>1234abcd-12ab-34cd-56ef-1234567890ab</code> </p> </li> <li> <p>Key ARN: <code>arn:aws:kms:us-east-2:111122223333:key/1234abcd-12ab-34cd-56ef-1234567890ab</code> </p> </li> </ul> <p>To get the key ID and key ARN for a CMK, use <a>ListKeys</a> or <a>DescribeKey</a>.</p>\"\
        },\
        \"WrappingAlgorithm\":{\
          \"shape\":\"AlgorithmSpec\",\
          \"documentation\":\"<p>The algorithm you will use to encrypt the key material before importing it with <a>ImportKeyMaterial</a>. For more information, see <a href=\\\"https://docs.aws.amazon.com/kms/latest/developerguide/importing-keys-encrypt-key-material.html\\\">Encrypt the Key Material</a> in the <i>AWS Key Management Service Developer Guide</i>.</p>\"\
        },\
        \"WrappingKeySpec\":{\
          \"shape\":\"WrappingKeySpec\",\
          \"documentation\":\"<p>The type of wrapping key (public key) to return in the response. Only 2048-bit RSA public keys are supported.</p>\"\
        }\
      }\
    },\
    \"GetParametersForImportResponse\":{\
      \"type\":\"structure\",\
      \"members\":{\
        \"KeyId\":{\
          \"shape\":\"KeyIdType\",\
          \"documentation\":\"<p>The identifier of the CMK to use in a subsequent <a>ImportKeyMaterial</a> request. This is the same CMK specified in the <code>GetParametersForImport</code> request.</p>\"\
        },\
        \"ImportToken\":{\
          \"shape\":\"CiphertextType\",\
          \"documentation\":\"<p>The import token to send in a subsequent <a>ImportKeyMaterial</a> request.</p>\"\
        },\
        \"PublicKey\":{\
          \"shape\":\"PlaintextType\",\
          \"documentation\":\"<p>The public key to use to encrypt the key material before importing it with <a>ImportKeyMaterial</a>.</p>\"\
        },\
        \"ParametersValidTo\":{\
          \"shape\":\"DateType\",\
          \"documentation\":\"<p>The time at which the import token and public key are no longer valid. After this time, you cannot use them to make an <a>ImportKeyMaterial</a> request and you must send another <code>GetParametersForImport</code> request to get new ones.</p>\"\
        }\
      }\
    },\
    \"GrantConstraints\":{\
      \"type\":\"structure\",\
      \"members\":{\
        \"EncryptionContextSubset\":{\
          \"shape\":\"EncryptionContextType\",\
          \"documentation\":\"<p>A list of key-value pairs that must be included in the encryption context of the cryptographic operation request. The grant allows the cryptographic operation only when the encryption context in the request includes the key-value pairs specified in this constraint, although it can include additional key-value pairs.</p>\"\
        },\
        \"EncryptionContextEquals\":{\
          \"shape\":\"EncryptionContextType\",\
          \"documentation\":\"<p>A list of key-value pairs that must match the encryption context in the cryptographic operation request. The grant allows the operation only when the encryption context in the request is the same as the encryption context specified in this constraint.</p>\"\
        }\
      },\
      \"documentation\":\"<p>Use this structure to allow cryptographic operations in the grant only when the operation request includes the specified <a href=\\\"https://docs.aws.amazon.com/kms/latest/developerguide/concepts.html#encrypt_context\\\">encryption context</a>.</p> <p>AWS KMS applies the grant constraints only when the grant allows a cryptographic operation that accepts an encryption context as input, such as the following.</p> <ul> <li> <p> <a>Encrypt</a> </p> </li> <li> <p> <a>Decrypt</a> </p> </li> <li> <p> <a>GenerateDataKey</a> </p> </li> <li> <p> <a>GenerateDataKeyWithoutPlaintext</a> </p> </li> <li> <p> <a>ReEncrypt</a> </p> </li> </ul> <p>AWS KMS does not apply the grant constraints to other operations, such as <a>DescribeKey</a> or <a>ScheduleKeyDeletion</a>.</p> <important> <p>In a cryptographic operation, the encryption context in the decryption operation must be an exact, case-sensitive match for the keys and values in the encryption context of the encryption operation. Only the order of the pairs can vary.</p> <p>However, in a grant constraint, the key in each key-value pair is not case sensitive, but the value is case sensitive.</p> <p>To avoid confusion, do not use multiple encryption context pairs that differ only by case. To require a fully case-sensitive encryption context, use the <code>kms:EncryptionContext:</code> and <code>kms:EncryptionContextKeys</code> conditions in an IAM or key policy. For details, see <a href=\\\"https://docs.aws.amazon.com/kms/latest/developerguide/policy-conditions.html#conditions-kms-encryption-context\\\">kms:EncryptionContext:</a> in the <i> <i>AWS Key Management Service Developer Guide</i> </i>.</p> </important>\"\
    },\
    \"GrantIdType\":{\
      \"type\":\"string\",\
      \"max\":128,\
      \"min\":1\
    },\
    \"GrantList\":{\
      \"type\":\"list\",\
      \"member\":{\"shape\":\"GrantListEntry\"}\
    },\
    \"GrantListEntry\":{\
      \"type\":\"structure\",\
      \"members\":{\
        \"KeyId\":{\
          \"shape\":\"KeyIdType\",\
          \"documentation\":\"<p>The unique identifier for the customer master key (CMK) to which the grant applies.</p>\"\
        },\
        \"GrantId\":{\
          \"shape\":\"GrantIdType\",\
          \"documentation\":\"<p>The unique identifier for the grant.</p>\"\
        },\
        \"Name\":{\
          \"shape\":\"GrantNameType\",\
          \"documentation\":\"<p>The friendly name that identifies the grant. If a name was provided in the <a>CreateGrant</a> request, that name is returned. Otherwise this value is null.</p>\"\
        },\
        \"CreationDate\":{\
          \"shape\":\"DateType\",\
          \"documentation\":\"<p>The date and time when the grant was created.</p>\"\
        },\
        \"GranteePrincipal\":{\
          \"shape\":\"PrincipalIdType\",\
          \"documentation\":\"<p>The principal that receives the grant's permissions.</p>\"\
        },\
        \"RetiringPrincipal\":{\
          \"shape\":\"PrincipalIdType\",\
          \"documentation\":\"<p>The principal that can retire the grant.</p>\"\
        },\
        \"IssuingAccount\":{\
          \"shape\":\"PrincipalIdType\",\
          \"documentation\":\"<p>The AWS account under which the grant was issued.</p>\"\
        },\
        \"Operations\":{\
          \"shape\":\"GrantOperationList\",\
          \"documentation\":\"<p>The list of operations permitted by the grant.</p>\"\
        },\
        \"Constraints\":{\
          \"shape\":\"GrantConstraints\",\
          \"documentation\":\"<p>A list of key-value pairs that must be present in the encryption context of certain subsequent operations that the grant allows.</p>\"\
        }\
      },\
      \"documentation\":\"<p>Contains information about an entry in a list of grants.</p>\"\
    },\
    \"GrantNameType\":{\
      \"type\":\"string\",\
      \"max\":256,\
      \"min\":1,\
      \"pattern\":\"^[a-zA-Z0-9:/_-]+$\"\
    },\
    \"GrantOperation\":{\
      \"type\":\"string\",\
      \"enum\":[\
        \"Decrypt\",\
        \"Encrypt\",\
        \"GenerateDataKey\",\
        \"GenerateDataKeyWithoutPlaintext\",\
        \"ReEncryptFrom\",\
        \"ReEncryptTo\",\
        \"CreateGrant\",\
        \"RetireGrant\",\
        \"DescribeKey\"\
      ]\
    },\
    \"GrantOperationList\":{\
      \"type\":\"list\",\
      \"member\":{\"shape\":\"GrantOperation\"}\
    },\
    \"GrantTokenList\":{\
      \"type\":\"list\",\
      \"member\":{\"shape\":\"GrantTokenType\"},\
      \"max\":10,\
      \"min\":0\
    },\
    \"GrantTokenType\":{\
      \"type\":\"string\",\
      \"max\":8192,\
      \"min\":1\
    },\
    \"ImportKeyMaterialRequest\":{\
      \"type\":\"structure\",\
      \"required\":[\
        \"KeyId\",\
        \"ImportToken\",\
        \"EncryptedKeyMaterial\"\
      ],\
      \"members\":{\
        \"KeyId\":{\
          \"shape\":\"KeyIdType\",\
          \"documentation\":\"<p>The identifier of the CMK to import the key material into. The CMK's <code>Origin</code> must be <code>EXTERNAL</code>.</p> <p>Specify the key ID or the Amazon Resource Name (ARN) of the CMK.</p> <p>For example:</p> <ul> <li> <p>Key ID: <code>1234abcd-12ab-34cd-56ef-1234567890ab</code> </p> </li> <li> <p>Key ARN: <code>arn:aws:kms:us-east-2:111122223333:key/1234abcd-12ab-34cd-56ef-1234567890ab</code> </p> </li> </ul> <p>To get the key ID and key ARN for a CMK, use <a>ListKeys</a> or <a>DescribeKey</a>.</p>\"\
        },\
        \"ImportToken\":{\
          \"shape\":\"CiphertextType\",\
          \"documentation\":\"<p>The import token that you received in the response to a previous <a>GetParametersForImport</a> request. It must be from the same response that contained the public key that you used to encrypt the key material.</p>\"\
        },\
        \"EncryptedKeyMaterial\":{\
          \"shape\":\"CiphertextType\",\
          \"documentation\":\"<p>The encrypted key material to import. It must be encrypted with the public key that you received in the response to a previous <a>GetParametersForImport</a> request, using the wrapping algorithm that you specified in that request.</p>\"\
        },\
        \"ValidTo\":{\
          \"shape\":\"DateType\",\
          \"documentation\":\"<p>The time at which the imported key material expires. When the key material expires, AWS KMS deletes the key material and the CMK becomes unusable. You must omit this parameter when the <code>ExpirationModel</code> parameter is set to <code>KEY_MATERIAL_DOES_NOT_EXPIRE</code>. Otherwise it is required.</p>\"\
        },\
        \"ExpirationModel\":{\
          \"shape\":\"ExpirationModelType\",\
          \"documentation\":\"<p>Specifies whether the key material expires. The default is <code>KEY_MATERIAL_EXPIRES</code>, in which case you must include the <code>ValidTo</code> parameter. When this parameter is set to <code>KEY_MATERIAL_DOES_NOT_EXPIRE</code>, you must omit the <code>ValidTo</code> parameter.</p>\"\
        }\
      }\
    },\
    \"ImportKeyMaterialResponse\":{\
      \"type\":\"structure\",\
      \"members\":{\
      }\
    },\
    \"IncorrectKeyMaterialException\":{\
      \"type\":\"structure\",\
      \"members\":{\
        \"message\":{\"shape\":\"ErrorMessageType\"}\
      },\
      \"documentation\":\"<p>The request was rejected because the provided key material is invalid or is not the same key material that was previously imported into this customer master key (CMK).</p>\",\
      \"exception\":true\
    },\
    \"IncorrectTrustAnchorException\":{\
      \"type\":\"structure\",\
      \"members\":{\
        \"message\":{\"shape\":\"ErrorMessageType\"}\
      },\
      \"documentation\":\"<p>The request was rejected because the trust anchor certificate in the request is not the trust anchor certificate for the specified AWS CloudHSM cluster.</p> <p>When you <a href=\\\"https://docs.aws.amazon.com/cloudhsm/latest/userguide/initialize-cluster.html#sign-csr\\\">initialize the cluster</a>, you create the trust anchor certificate and save it in the <code>customerCA.crt</code> file.</p>\",\
      \"exception\":true\
    },\
    \"InvalidAliasNameException\":{\
      \"type\":\"structure\",\
      \"members\":{\
        \"message\":{\"shape\":\"ErrorMessageType\"}\
      },\
      \"documentation\":\"<p>The request was rejected because the specified alias name is not valid.</p>\",\
      \"exception\":true\
    },\
    \"InvalidArnException\":{\
      \"type\":\"structure\",\
      \"members\":{\
        \"message\":{\"shape\":\"ErrorMessageType\"}\
      },\
      \"documentation\":\"<p>The request was rejected because a specified ARN, or an ARN in a key policy, is not valid.</p>\",\
      \"exception\":true\
    },\
    \"InvalidCiphertextException\":{\
      \"type\":\"structure\",\
      \"members\":{\
        \"message\":{\"shape\":\"ErrorMessageType\"}\
      },\
      \"documentation\":\"<p>The request was rejected because the specified ciphertext, or additional authenticated data incorporated into the ciphertext, such as the encryption context, is corrupted, missing, or otherwise invalid.</p>\",\
      \"exception\":true\
    },\
    \"InvalidGrantIdException\":{\
      \"type\":\"structure\",\
      \"members\":{\
        \"message\":{\"shape\":\"ErrorMessageType\"}\
      },\
      \"documentation\":\"<p>The request was rejected because the specified <code>GrantId</code> is not valid.</p>\",\
      \"exception\":true\
    },\
    \"InvalidGrantTokenException\":{\
      \"type\":\"structure\",\
      \"members\":{\
        \"message\":{\"shape\":\"ErrorMessageType\"}\
      },\
      \"documentation\":\"<p>The request was rejected because the specified grant token is not valid.</p>\",\
      \"exception\":true\
    },\
    \"InvalidImportTokenException\":{\
      \"type\":\"structure\",\
      \"members\":{\
        \"message\":{\"shape\":\"ErrorMessageType\"}\
      },\
      \"documentation\":\"<p>The request was rejected because the provided import token is invalid or is associated with a different customer master key (CMK).</p>\",\
      \"exception\":true\
    },\
    \"InvalidKeyUsageException\":{\
      \"type\":\"structure\",\
      \"members\":{\
        \"message\":{\"shape\":\"ErrorMessageType\"}\
      },\
      \"documentation\":\"<p>The request was rejected because the specified <code>KeySpec</code> value is not valid.</p>\",\
      \"exception\":true\
    },\
    \"InvalidMarkerException\":{\
      \"type\":\"structure\",\
      \"members\":{\
        \"message\":{\"shape\":\"ErrorMessageType\"}\
      },\
      \"documentation\":\"<p>The request was rejected because the marker that specifies where pagination should next begin is not valid.</p>\",\
      \"exception\":true\
    },\
    \"KMSInternalException\":{\
      \"type\":\"structure\",\
      \"members\":{\
        \"message\":{\"shape\":\"ErrorMessageType\"}\
      },\
      \"documentation\":\"<p>The request was rejected because an internal exception occurred. The request can be retried.</p>\",\
      \"exception\":true,\
      \"fault\":true\
    },\
    \"KMSInvalidStateException\":{\
      \"type\":\"structure\",\
      \"members\":{\
        \"message\":{\"shape\":\"ErrorMessageType\"}\
      },\
      \"documentation\":\"<p>The request was rejected because the state of the specified resource is not valid for this request.</p> <p>For more information about how key state affects the use of a CMK, see <a href=\\\"https://docs.aws.amazon.com/kms/latest/developerguide/key-state.html\\\">How Key State Affects Use of a Customer Master Key</a> in the <i>AWS Key Management Service Developer Guide</i>.</p>\",\
      \"exception\":true\
    },\
    \"KeyIdType\":{\
      \"type\":\"string\",\
      \"max\":2048,\
      \"min\":1\
    },\
    \"KeyList\":{\
      \"type\":\"list\",\
      \"member\":{\"shape\":\"KeyListEntry\"}\
    },\
    \"KeyListEntry\":{\
      \"type\":\"structure\",\
      \"members\":{\
        \"KeyId\":{\
          \"shape\":\"KeyIdType\",\
          \"documentation\":\"<p>Unique identifier of the key.</p>\"\
        },\
        \"KeyArn\":{\
          \"shape\":\"ArnType\",\
          \"documentation\":\"<p>ARN of the key.</p>\"\
        }\
      },\
      \"documentation\":\"<p>Contains information about each entry in the key list.</p>\"\
    },\
    \"KeyManagerType\":{\
      \"type\":\"string\",\
      \"enum\":[\
        \"AWS\",\
        \"CUSTOMER\"\
      ]\
    },\
    \"KeyMetadata\":{\
      \"type\":\"structure\",\
      \"required\":[\"KeyId\"],\
      \"members\":{\
        \"AWSAccountId\":{\
          \"shape\":\"AWSAccountIdType\",\
          \"documentation\":\"<p>The twelve-digit account ID of the AWS account that owns the CMK.</p>\"\
        },\
        \"KeyId\":{\
          \"shape\":\"KeyIdType\",\
          \"documentation\":\"<p>The globally unique identifier for the CMK.</p>\"\
        },\
        \"Arn\":{\
          \"shape\":\"ArnType\",\
          \"documentation\":\"<p>The Amazon Resource Name (ARN) of the CMK. For examples, see <a href=\\\"https://docs.aws.amazon.com/general/latest/gr/aws-arns-and-namespaces.html#arn-syntax-kms\\\">AWS Key Management Service (AWS KMS)</a> in the Example ARNs section of the <i>AWS General Reference</i>.</p>\"\
        },\
        \"CreationDate\":{\
          \"shape\":\"DateType\",\
          \"documentation\":\"<p>The date and time when the CMK was created.</p>\"\
        },\
        \"Enabled\":{\
          \"shape\":\"BooleanType\",\
          \"documentation\":\"<p>Specifies whether the CMK is enabled. When <code>KeyState</code> is <code>Enabled</code> this value is true, otherwise it is false.</p>\"\
        },\
        \"Description\":{\
          \"shape\":\"DescriptionType\",\
          \"documentation\":\"<p>The description of the CMK.</p>\"\
        },\
        \"KeyUsage\":{\
          \"shape\":\"KeyUsageType\",\
          \"documentation\":\"<p>The cryptographic operations for which you can use the CMK. The only valid value is <code>ENCRYPT_DECRYPT</code>, which means you can use the CMK to encrypt and decrypt data.</p>\"\
        },\
        \"KeyState\":{\
          \"shape\":\"KeyState\",\
          \"documentation\":\"<p>The state of the CMK.</p> <p>For more information about how key state affects the use of a CMK, see <a href=\\\"https://docs.aws.amazon.com/kms/latest/developerguide/key-state.html\\\">How Key State Affects the Use of a Customer Master Key</a> in the <i>AWS Key Management Service Developer Guide</i>.</p>\"\
        },\
        \"DeletionDate\":{\
          \"shape\":\"DateType\",\
          \"documentation\":\"<p>The date and time after which AWS KMS deletes the CMK. This value is present only when <code>KeyState</code> is <code>PendingDeletion</code>.</p>\"\
        },\
        \"ValidTo\":{\
          \"shape\":\"DateType\",\
          \"documentation\":\"<p>The time at which the imported key material expires. When the key material expires, AWS KMS deletes the key material and the CMK becomes unusable. This value is present only for CMKs whose <code>Origin</code> is <code>EXTERNAL</code> and whose <code>ExpirationModel</code> is <code>KEY_MATERIAL_EXPIRES</code>, otherwise this value is omitted.</p>\"\
        },\
        \"Origin\":{\
          \"shape\":\"OriginType\",\
          \"documentation\":\"<p>The source of the CMK's key material. When this value is <code>AWS_KMS</code>, AWS KMS created the key material. When this value is <code>EXTERNAL</code>, the key material was imported from your existing key management infrastructure or the CMK lacks key material. When this value is <code>AWS_CLOUDHSM</code>, the key material was created in the AWS CloudHSM cluster associated with a custom key store.</p>\"\
        },\
        \"CustomKeyStoreId\":{\
          \"shape\":\"CustomKeyStoreIdType\",\
          \"documentation\":\"<p>A unique identifier for the <a href=\\\"https://docs.aws.amazon.com/kms/latest/developerguide/custom-key-store-overview.html\\\">custom key store</a> that contains the CMK. This value is present only when the CMK is created in a custom key store.</p>\"\
        },\
        \"CloudHsmClusterId\":{\
          \"shape\":\"CloudHsmClusterIdType\",\
          \"documentation\":\"<p>The cluster ID of the AWS CloudHSM cluster that contains the key material for the CMK. When you create a CMK in a <a href=\\\"https://docs.aws.amazon.com/kms/latest/developerguide/custom-key-store-overview.html\\\">custom key store</a>, AWS KMS creates the key material for the CMK in the associated AWS CloudHSM cluster. This value is present only when the CMK is created in a custom key store.</p>\"\
        },\
        \"ExpirationModel\":{\
          \"shape\":\"ExpirationModelType\",\
          \"documentation\":\"<p>Specifies whether the CMK's key material expires. This value is present only when <code>Origin</code> is <code>EXTERNAL</code>, otherwise this value is omitted.</p>\"\
        },\
        \"KeyManager\":{\
          \"shape\":\"KeyManagerType\",\
          \"documentation\":\"<p>The manager of the CMK. CMKs in your AWS account are either customer managed or AWS managed. For more information about the difference, see <a href=\\\"https://docs.aws.amazon.com/kms/latest/developerguide/concepts.html#master_keys\\\">Customer Master Keys</a> in the <i>AWS Key Management Service Developer Guide</i>.</p>\"\
        }\
      },\
      \"documentation\":\"<p>Contains metadata about a customer master key (CMK).</p> <p>This data type is used as a response element for the <a>CreateKey</a> and <a>DescribeKey</a> operations.</p>\"\
    },\
    \"KeyState\":{\
      \"type\":\"string\",\
      \"enum\":[\
        \"Enabled\",\
        \"Disabled\",\
        \"PendingDeletion\",\
        \"PendingImport\",\
        \"Unavailable\"\
      ]\
    },\
    \"KeyStorePasswordType\":{\
      \"type\":\"string\",\
      \"min\":1,\
      \"sensitive\":true\
    },\
    \"KeyUnavailableException\":{\
      \"type\":\"structure\",\
      \"members\":{\
        \"message\":{\"shape\":\"ErrorMessageType\"}\
      },\
      \"documentation\":\"<p>The request was rejected because the specified CMK was not available. The request can be retried.</p>\",\
      \"exception\":true,\
      \"fault\":true\
    },\
    \"KeyUsageType\":{\
      \"type\":\"string\",\
      \"enum\":[\"ENCRYPT_DECRYPT\"]\
    },\
    \"LimitExceededException\":{\
      \"type\":\"structure\",\
      \"members\":{\
        \"message\":{\"shape\":\"ErrorMessageType\"}\
      },\
      \"documentation\":\"<p>The request was rejected because a limit was exceeded. For more information, see <a href=\\\"https://docs.aws.amazon.com/kms/latest/developerguide/limits.html\\\">Limits</a> in the <i>AWS Key Management Service Developer Guide</i>.</p>\",\
      \"exception\":true\
    },\
    \"LimitType\":{\
      \"type\":\"integer\",\
      \"max\":1000,\
      \"min\":1\
    },\
    \"ListAliasesRequest\":{\
      \"type\":\"structure\",\
      \"members\":{\
        \"KeyId\":{\
          \"shape\":\"KeyIdType\",\
          \"documentation\":\"<p>Lists only aliases that refer to the specified CMK. The value of this parameter can be the ID or Amazon Resource Name (ARN) of a CMK in the caller's account and region. You cannot use an alias name or alias ARN in this value.</p> <p>This parameter is optional. If you omit it, <code>ListAliases</code> returns all aliases in the account and region.</p>\"\
        },\
        \"Limit\":{\
          \"shape\":\"LimitType\",\
          \"documentation\":\"<p>Use this parameter to specify the maximum number of items to return. When this value is present, AWS KMS does not return more than the specified number of items, but it might return fewer.</p> <p>This value is optional. If you include a value, it must be between 1 and 100, inclusive. If you do not include a value, it defaults to 50.</p>\"\
        },\
        \"Marker\":{\
          \"shape\":\"MarkerType\",\
          \"documentation\":\"<p>Use this parameter in a subsequent request after you receive a response with truncated results. Set it to the value of <code>NextMarker</code> from the truncated response you just received.</p>\"\
        }\
      }\
    },\
    \"ListAliasesResponse\":{\
      \"type\":\"structure\",\
      \"members\":{\
        \"Aliases\":{\
          \"shape\":\"AliasList\",\
          \"documentation\":\"<p>A list of aliases.</p>\"\
        },\
        \"NextMarker\":{\
          \"shape\":\"MarkerType\",\
          \"documentation\":\"<p>When <code>Truncated</code> is true, this element is present and contains the value to use for the <code>Marker</code> parameter in a subsequent request.</p>\"\
        },\
        \"Truncated\":{\
          \"shape\":\"BooleanType\",\
          \"documentation\":\"<p>A flag that indicates whether there are more items in the list. When this value is true, the list in this response is truncated. To get more items, pass the value of the <code>NextMarker</code> element in thisresponse to the <code>Marker</code> parameter in a subsequent request.</p>\"\
        }\
      }\
    },\
    \"ListGrantsRequest\":{\
      \"type\":\"structure\",\
      \"required\":[\"KeyId\"],\
      \"members\":{\
        \"Limit\":{\
          \"shape\":\"LimitType\",\
          \"documentation\":\"<p>Use this parameter to specify the maximum number of items to return. When this value is present, AWS KMS does not return more than the specified number of items, but it might return fewer.</p> <p>This value is optional. If you include a value, it must be between 1 and 100, inclusive. If you do not include a value, it defaults to 50.</p>\"\
        },\
        \"Marker\":{\
          \"shape\":\"MarkerType\",\
          \"documentation\":\"<p>Use this parameter in a subsequent request after you receive a response with truncated results. Set it to the value of <code>NextMarker</code> from the truncated response you just received.</p>\"\
        },\
        \"KeyId\":{\
          \"shape\":\"KeyIdType\",\
          \"documentation\":\"<p>A unique identifier for the customer master key (CMK).</p> <p>Specify the key ID or the Amazon Resource Name (ARN) of the CMK. To specify a CMK in a different AWS account, you must use the key ARN.</p> <p>For example:</p> <ul> <li> <p>Key ID: <code>1234abcd-12ab-34cd-56ef-1234567890ab</code> </p> </li> <li> <p>Key ARN: <code>arn:aws:kms:us-east-2:111122223333:key/1234abcd-12ab-34cd-56ef-1234567890ab</code> </p> </li> </ul> <p>To get the key ID and key ARN for a CMK, use <a>ListKeys</a> or <a>DescribeKey</a>.</p>\"\
        }\
      }\
    },\
    \"ListGrantsResponse\":{\
      \"type\":\"structure\",\
      \"members\":{\
        \"Grants\":{\
          \"shape\":\"GrantList\",\
          \"documentation\":\"<p>A list of grants.</p>\"\
        },\
        \"NextMarker\":{\
          \"shape\":\"MarkerType\",\
          \"documentation\":\"<p>When <code>Truncated</code> is true, this element is present and contains the value to use for the <code>Marker</code> parameter in a subsequent request.</p>\"\
        },\
        \"Truncated\":{\
          \"shape\":\"BooleanType\",\
          \"documentation\":\"<p>A flag that indicates whether there are more items in the list. When this value is true, the list in this response is truncated. To get more items, pass the value of the <code>NextMarker</code> element in thisresponse to the <code>Marker</code> parameter in a subsequent request.</p>\"\
        }\
      }\
    },\
    \"ListKeyPoliciesRequest\":{\
      \"type\":\"structure\",\
      \"required\":[\"KeyId\"],\
      \"members\":{\
        \"KeyId\":{\
          \"shape\":\"KeyIdType\",\
          \"documentation\":\"<p>A unique identifier for the customer master key (CMK).</p> <p>Specify the key ID or the Amazon Resource Name (ARN) of the CMK.</p> <p>For example:</p> <ul> <li> <p>Key ID: <code>1234abcd-12ab-34cd-56ef-1234567890ab</code> </p> </li> <li> <p>Key ARN: <code>arn:aws:kms:us-east-2:111122223333:key/1234abcd-12ab-34cd-56ef-1234567890ab</code> </p> </li> </ul> <p>To get the key ID and key ARN for a CMK, use <a>ListKeys</a> or <a>DescribeKey</a>.</p>\"\
        },\
        \"Limit\":{\
          \"shape\":\"LimitType\",\
          \"documentation\":\"<p>Use this parameter to specify the maximum number of items to return. When this value is present, AWS KMS does not return more than the specified number of items, but it might return fewer.</p> <p>This value is optional. If you include a value, it must be between 1 and 1000, inclusive. If you do not include a value, it defaults to 100.</p> <p>Only one policy can be attached to a key.</p>\"\
        },\
        \"Marker\":{\
          \"shape\":\"MarkerType\",\
          \"documentation\":\"<p>Use this parameter in a subsequent request after you receive a response with truncated results. Set it to the value of <code>NextMarker</code> from the truncated response you just received.</p>\"\
        }\
      }\
    },\
    \"ListKeyPoliciesResponse\":{\
      \"type\":\"structure\",\
      \"members\":{\
        \"PolicyNames\":{\
          \"shape\":\"PolicyNameList\",\
          \"documentation\":\"<p>A list of key policy names. The only valid value is <code>default</code>.</p>\"\
        },\
        \"NextMarker\":{\
          \"shape\":\"MarkerType\",\
          \"documentation\":\"<p>When <code>Truncated</code> is true, this element is present and contains the value to use for the <code>Marker</code> parameter in a subsequent request.</p>\"\
        },\
        \"Truncated\":{\
          \"shape\":\"BooleanType\",\
          \"documentation\":\"<p>A flag that indicates whether there are more items in the list. When this value is true, the list in this response is truncated. To get more items, pass the value of the <code>NextMarker</code> element in thisresponse to the <code>Marker</code> parameter in a subsequent request.</p>\"\
        }\
      }\
    },\
    \"ListKeysRequest\":{\
      \"type\":\"structure\",\
      \"members\":{\
        \"Limit\":{\
          \"shape\":\"LimitType\",\
          \"documentation\":\"<p>Use this parameter to specify the maximum number of items to return. When this value is present, AWS KMS does not return more than the specified number of items, but it might return fewer.</p> <p>This value is optional. If you include a value, it must be between 1 and 1000, inclusive. If you do not include a value, it defaults to 100.</p>\"\
        },\
        \"Marker\":{\
          \"shape\":\"MarkerType\",\
          \"documentation\":\"<p>Use this parameter in a subsequent request after you receive a response with truncated results. Set it to the value of <code>NextMarker</code> from the truncated response you just received.</p>\"\
        }\
      }\
    },\
    \"ListKeysResponse\":{\
      \"type\":\"structure\",\
      \"members\":{\
        \"Keys\":{\
          \"shape\":\"KeyList\",\
          \"documentation\":\"<p>A list of customer master keys (CMKs).</p>\"\
        },\
        \"NextMarker\":{\
          \"shape\":\"MarkerType\",\
          \"documentation\":\"<p>When <code>Truncated</code> is true, this element is present and contains the value to use for the <code>Marker</code> parameter in a subsequent request.</p>\"\
        },\
        \"Truncated\":{\
          \"shape\":\"BooleanType\",\
          \"documentation\":\"<p>A flag that indicates whether there are more items in the list. When this value is true, the list in this response is truncated. To get more items, pass the value of the <code>NextMarker</code> element in thisresponse to the <code>Marker</code> parameter in a subsequent request.</p>\"\
        }\
      }\
    },\
    \"ListResourceTagsRequest\":{\
      \"type\":\"structure\",\
      \"required\":[\"KeyId\"],\
      \"members\":{\
        \"KeyId\":{\
          \"shape\":\"KeyIdType\",\
          \"documentation\":\"<p>A unique identifier for the customer master key (CMK).</p> <p>Specify the key ID or the Amazon Resource Name (ARN) of the CMK.</p> <p>For example:</p> <ul> <li> <p>Key ID: <code>1234abcd-12ab-34cd-56ef-1234567890ab</code> </p> </li> <li> <p>Key ARN: <code>arn:aws:kms:us-east-2:111122223333:key/1234abcd-12ab-34cd-56ef-1234567890ab</code> </p> </li> </ul> <p>To get the key ID and key ARN for a CMK, use <a>ListKeys</a> or <a>DescribeKey</a>.</p>\"\
        },\
        \"Limit\":{\
          \"shape\":\"LimitType\",\
          \"documentation\":\"<p>Use this parameter to specify the maximum number of items to return. When this value is present, AWS KMS does not return more than the specified number of items, but it might return fewer.</p> <p>This value is optional. If you include a value, it must be between 1 and 50, inclusive. If you do not include a value, it defaults to 50.</p>\"\
        },\
        \"Marker\":{\
          \"shape\":\"MarkerType\",\
          \"documentation\":\"<p>Use this parameter in a subsequent request after you receive a response with truncated results. Set it to the value of <code>NextMarker</code> from the truncated response you just received.</p> <p>Do not attempt to construct this value. Use only the value of <code>NextMarker</code> from the truncated response you just received.</p>\"\
        }\
      }\
    },\
    \"ListResourceTagsResponse\":{\
      \"type\":\"structure\",\
      \"members\":{\
        \"Tags\":{\
          \"shape\":\"TagList\",\
          \"documentation\":\"<p>A list of tags. Each tag consists of a tag key and a tag value.</p>\"\
        },\
        \"NextMarker\":{\
          \"shape\":\"MarkerType\",\
          \"documentation\":\"<p>When <code>Truncated</code> is true, this element is present and contains the value to use for the <code>Marker</code> parameter in a subsequent request.</p> <p>Do not assume or infer any information from this value.</p>\"\
        },\
        \"Truncated\":{\
          \"shape\":\"BooleanType\",\
          \"documentation\":\"<p>A flag that indicates whether there are more items in the list. When this value is true, the list in this response is truncated. To get more items, pass the value of the <code>NextMarker</code> element in thisresponse to the <code>Marker</code> parameter in a subsequent request.</p>\"\
        }\
      }\
    },\
    \"ListRetirableGrantsRequest\":{\
      \"type\":\"structure\",\
      \"required\":[\"RetiringPrincipal\"],\
      \"members\":{\
        \"Limit\":{\
          \"shape\":\"LimitType\",\
          \"documentation\":\"<p>Use this parameter to specify the maximum number of items to return. When this value is present, AWS KMS does not return more than the specified number of items, but it might return fewer.</p> <p>This value is optional. If you include a value, it must be between 1 and 100, inclusive. If you do not include a value, it defaults to 50.</p>\"\
        },\
        \"Marker\":{\
          \"shape\":\"MarkerType\",\
          \"documentation\":\"<p>Use this parameter in a subsequent request after you receive a response with truncated results. Set it to the value of <code>NextMarker</code> from the truncated response you just received.</p>\"\
        },\
        \"RetiringPrincipal\":{\
          \"shape\":\"PrincipalIdType\",\
          \"documentation\":\"<p>The retiring principal for which to list grants.</p> <p>To specify the retiring principal, use the <a href=\\\"https://docs.aws.amazon.com/general/latest/gr/aws-arns-and-namespaces.html\\\">Amazon Resource Name (ARN)</a> of an AWS principal. Valid AWS principals include AWS accounts (root), IAM users, federated users, and assumed role users. For examples of the ARN syntax for specifying a principal, see <a href=\\\"https://docs.aws.amazon.com/general/latest/gr/aws-arns-and-namespaces.html#arn-syntax-iam\\\">AWS Identity and Access Management (IAM)</a> in the Example ARNs section of the <i>Amazon Web Services General Reference</i>.</p>\"\
        }\
      }\
    },\
    \"MalformedPolicyDocumentException\":{\
      \"type\":\"structure\",\
      \"members\":{\
        \"message\":{\"shape\":\"ErrorMessageType\"}\
      },\
      \"documentation\":\"<p>The request was rejected because the specified policy is not syntactically or semantically correct.</p>\",\
      \"exception\":true\
    },\
    \"MarkerType\":{\
      \"type\":\"string\",\
      \"max\":1024,\
      \"min\":1,\
      \"pattern\":\"[\\\\u0020-\\\\u00FF]*\"\
    },\
    \"NotFoundException\":{\
      \"type\":\"structure\",\
      \"members\":{\
        \"message\":{\"shape\":\"ErrorMessageType\"}\
      },\
      \"documentation\":\"<p>The request was rejected because the specified entity or resource could not be found.</p>\",\
      \"exception\":true\
    },\
    \"NumberOfBytesType\":{\
      \"type\":\"integer\",\
      \"max\":1024,\
      \"min\":1\
    },\
    \"OriginType\":{\
      \"type\":\"string\",\
      \"enum\":[\
        \"AWS_KMS\",\
        \"EXTERNAL\",\
        \"AWS_CLOUDHSM\"\
      ]\
    },\
    \"PendingWindowInDaysType\":{\
      \"type\":\"integer\",\
      \"max\":365,\
      \"min\":1\
    },\
    \"PlaintextType\":{\
      \"type\":\"blob\",\
      \"max\":4096,\
      \"min\":1,\
      \"sensitive\":true\
    },\
    \"PolicyNameList\":{\
      \"type\":\"list\",\
      \"member\":{\"shape\":\"PolicyNameType\"}\
    },\
    \"PolicyNameType\":{\
      \"type\":\"string\",\
      \"max\":128,\
      \"min\":1,\
      \"pattern\":\"[\\\\w]+\"\
    },\
    \"PolicyType\":{\
      \"type\":\"string\",\
      \"max\":131072,\
      \"min\":1,\
      \"pattern\":\"[\\\\u0009\\\\u000A\\\\u000D\\\\u0020-\\\\u00FF]+\"\
    },\
    \"PrincipalIdType\":{\
      \"type\":\"string\",\
      \"max\":256,\
      \"min\":1,\
      \"pattern\":\"^[\\\\w+=,.@:/-]+$\"\
    },\
    \"PutKeyPolicyRequest\":{\
      \"type\":\"structure\",\
      \"required\":[\
        \"KeyId\",\
        \"PolicyName\",\
        \"Policy\"\
      ],\
      \"members\":{\
        \"KeyId\":{\
          \"shape\":\"KeyIdType\",\
          \"documentation\":\"<p>A unique identifier for the customer master key (CMK).</p> <p>Specify the key ID or the Amazon Resource Name (ARN) of the CMK.</p> <p>For example:</p> <ul> <li> <p>Key ID: <code>1234abcd-12ab-34cd-56ef-1234567890ab</code> </p> </li> <li> <p>Key ARN: <code>arn:aws:kms:us-east-2:111122223333:key/1234abcd-12ab-34cd-56ef-1234567890ab</code> </p> </li> </ul> <p>To get the key ID and key ARN for a CMK, use <a>ListKeys</a> or <a>DescribeKey</a>.</p>\"\
        },\
        \"PolicyName\":{\
          \"shape\":\"PolicyNameType\",\
          \"documentation\":\"<p>The name of the key policy. The only valid value is <code>default</code>.</p>\"\
        },\
        \"Policy\":{\
          \"shape\":\"PolicyType\",\
          \"documentation\":\"<p>The key policy to attach to the CMK.</p> <p>The key policy must meet the following criteria:</p> <ul> <li> <p>If you don't set <code>BypassPolicyLockoutSafetyCheck</code> to true, the key policy must allow the principal that is making the <code>PutKeyPolicy</code> request to make a subsequent <code>PutKeyPolicy</code> request on the CMK. This reduces the risk that the CMK becomes unmanageable. For more information, refer to the scenario in the <a href=\\\"https://docs.aws.amazon.com/kms/latest/developerguide/key-policies.html#key-policy-default-allow-root-enable-iam\\\">Default Key Policy</a> section of the <i>AWS Key Management Service Developer Guide</i>.</p> </li> <li> <p>Each statement in the key policy must contain one or more principals. The principals in the key policy must exist and be visible to AWS KMS. When you create a new AWS principal (for example, an IAM user or role), you might need to enforce a delay before including the new principal in a key policy because the new principal might not be immediately visible to AWS KMS. For more information, see <a href=\\\"https://docs.aws.amazon.com/IAM/latest/UserGuide/troubleshoot_general.html#troubleshoot_general_eventual-consistency\\\">Changes that I make are not always immediately visible</a> in the <i>AWS Identity and Access Management User Guide</i>.</p> </li> </ul> <p>The key policy size limit is 32 kilobytes (32768 bytes).</p>\"\
        },\
        \"BypassPolicyLockoutSafetyCheck\":{\
          \"shape\":\"BooleanType\",\
          \"documentation\":\"<p>A flag to indicate whether to bypass the key policy lockout safety check.</p> <important> <p>Setting this value to true increases the risk that the CMK becomes unmanageable. Do not set this value to true indiscriminately.</p> <p>For more information, refer to the scenario in the <a href=\\\"https://docs.aws.amazon.com/kms/latest/developerguide/key-policies.html#key-policy-default-allow-root-enable-iam\\\">Default Key Policy</a> section in the <i>AWS Key Management Service Developer Guide</i>.</p> </important> <p>Use this parameter only when you intend to prevent the principal that is making the request from making a subsequent <code>PutKeyPolicy</code> request on the CMK.</p> <p>The default value is false.</p>\"\
        }\
      }\
    },\
    \"ReEncryptRequest\":{\
      \"type\":\"structure\",\
      \"required\":[\
        \"CiphertextBlob\",\
        \"DestinationKeyId\"\
      ],\
      \"members\":{\
        \"CiphertextBlob\":{\
          \"shape\":\"CiphertextType\",\
          \"documentation\":\"<p>Ciphertext of the data to reencrypt.</p>\"\
        },\
        \"SourceEncryptionContext\":{\
          \"shape\":\"EncryptionContextType\",\
          \"documentation\":\"<p>Encryption context used to encrypt and decrypt the data specified in the <code>CiphertextBlob</code> parameter.</p>\"\
        },\
        \"DestinationKeyId\":{\
          \"shape\":\"KeyIdType\",\
          \"documentation\":\"<p>A unique identifier for the CMK that is used to reencrypt the data.</p> <p>To specify a CMK, use its key ID, Amazon Resource Name (ARN), alias name, or alias ARN. When using an alias name, prefix it with <code>\\\"alias/\\\"</code>. To specify a CMK in a different AWS account, you must use the key ARN or alias ARN.</p> <p>For example:</p> <ul> <li> <p>Key ID: <code>1234abcd-12ab-34cd-56ef-1234567890ab</code> </p> </li> <li> <p>Key ARN: <code>arn:aws:kms:us-east-2:111122223333:key/1234abcd-12ab-34cd-56ef-1234567890ab</code> </p> </li> <li> <p>Alias name: <code>alias/ExampleAlias</code> </p> </li> <li> <p>Alias ARN: <code>arn:aws:kms:us-east-2:111122223333:alias/ExampleAlias</code> </p> </li> </ul> <p>To get the key ID and key ARN for a CMK, use <a>ListKeys</a> or <a>DescribeKey</a>. To get the alias name and alias ARN, use <a>ListAliases</a>.</p>\"\
        },\
        \"DestinationEncryptionContext\":{\
          \"shape\":\"EncryptionContextType\",\
          \"documentation\":\"<p>Encryption context to use when the data is reencrypted.</p>\"\
        },\
        \"GrantTokens\":{\
          \"shape\":\"GrantTokenList\",\
          \"documentation\":\"<p>A list of grant tokens.</p> <p>For more information, see <a href=\\\"https://docs.aws.amazon.com/kms/latest/developerguide/concepts.html#grant_token\\\">Grant Tokens</a> in the <i>AWS Key Management Service Developer Guide</i>.</p>\"\
        }\
      }\
    },\
    \"ReEncryptResponse\":{\
      \"type\":\"structure\",\
      \"members\":{\
        \"CiphertextBlob\":{\
          \"shape\":\"CiphertextType\",\
          \"documentation\":\"<p>The reencrypted data. When you use the HTTP API or the AWS CLI, the value is Base64-encoded. Otherwise, it is not encoded.</p>\"\
        },\
        \"SourceKeyId\":{\
          \"shape\":\"KeyIdType\",\
          \"documentation\":\"<p>Unique identifier of the CMK used to originally encrypt the data.</p>\"\
        },\
        \"KeyId\":{\
          \"shape\":\"KeyIdType\",\
          \"documentation\":\"<p>Unique identifier of the CMK used to reencrypt the data.</p>\"\
        }\
      }\
    },\
    \"RetireGrantRequest\":{\
      \"type\":\"structure\",\
      \"members\":{\
        \"GrantToken\":{\
          \"shape\":\"GrantTokenType\",\
          \"documentation\":\"<p>Token that identifies the grant to be retired.</p>\"\
        },\
        \"KeyId\":{\
          \"shape\":\"KeyIdType\",\
          \"documentation\":\"<p>The Amazon Resource Name (ARN) of the CMK associated with the grant. </p> <p>For example: <code>arn:aws:kms:us-east-2:444455556666:key/1234abcd-12ab-34cd-56ef-1234567890ab</code> </p>\"\
        },\
        \"GrantId\":{\
          \"shape\":\"GrantIdType\",\
          \"documentation\":\"<p>Unique identifier of the grant to retire. The grant ID is returned in the response to a <code>CreateGrant</code> operation.</p> <ul> <li> <p>Grant ID Example - 0123456789012345678901234567890123456789012345678901234567890123</p> </li> </ul>\"\
        }\
      }\
    },\
    \"RevokeGrantRequest\":{\
      \"type\":\"structure\",\
      \"required\":[\
        \"KeyId\",\
        \"GrantId\"\
      ],\
      \"members\":{\
        \"KeyId\":{\
          \"shape\":\"KeyIdType\",\
          \"documentation\":\"<p>A unique identifier for the customer master key associated with the grant.</p> <p>Specify the key ID or the Amazon Resource Name (ARN) of the CMK. To specify a CMK in a different AWS account, you must use the key ARN.</p> <p>For example:</p> <ul> <li> <p>Key ID: <code>1234abcd-12ab-34cd-56ef-1234567890ab</code> </p> </li> <li> <p>Key ARN: <code>arn:aws:kms:us-east-2:111122223333:key/1234abcd-12ab-34cd-56ef-1234567890ab</code> </p> </li> </ul> <p>To get the key ID and key ARN for a CMK, use <a>ListKeys</a> or <a>DescribeKey</a>.</p>\"\
        },\
        \"GrantId\":{\
          \"shape\":\"GrantIdType\",\
          \"documentation\":\"<p>Identifier of the grant to be revoked.</p>\"\
        }\
      }\
    },\
    \"ScheduleKeyDeletionRequest\":{\
      \"type\":\"structure\",\
      \"required\":[\"KeyId\"],\
      \"members\":{\
        \"KeyId\":{\
          \"shape\":\"KeyIdType\",\
          \"documentation\":\"<p>The unique identifier of the customer master key (CMK) to delete.</p> <p>Specify the key ID or the Amazon Resource Name (ARN) of the CMK.</p> <p>For example:</p> <ul> <li> <p>Key ID: <code>1234abcd-12ab-34cd-56ef-1234567890ab</code> </p> </li> <li> <p>Key ARN: <code>arn:aws:kms:us-east-2:111122223333:key/1234abcd-12ab-34cd-56ef-1234567890ab</code> </p> </li> </ul> <p>To get the key ID and key ARN for a CMK, use <a>ListKeys</a> or <a>DescribeKey</a>.</p>\"\
        },\
        \"PendingWindowInDays\":{\
          \"shape\":\"PendingWindowInDaysType\",\
          \"documentation\":\"<p>The waiting period, specified in number of days. After the waiting period ends, AWS KMS deletes the customer master key (CMK).</p> <p>This value is optional. If you include a value, it must be between 7 and 30, inclusive. If you do not include a value, it defaults to 30.</p>\"\
        }\
      }\
    },\
    \"ScheduleKeyDeletionResponse\":{\
      \"type\":\"structure\",\
      \"members\":{\
        \"KeyId\":{\
          \"shape\":\"KeyIdType\",\
          \"documentation\":\"<p>The unique identifier of the customer master key (CMK) for which deletion is scheduled.</p>\"\
        },\
        \"DeletionDate\":{\
          \"shape\":\"DateType\",\
          \"documentation\":\"<p>The date and time after which AWS KMS deletes the customer master key (CMK).</p>\"\
        }\
      }\
    },\
    \"Tag\":{\
      \"type\":\"structure\",\
      \"required\":[\
        \"TagKey\",\
        \"TagValue\"\
      ],\
      \"members\":{\
        \"TagKey\":{\
          \"shape\":\"TagKeyType\",\
          \"documentation\":\"<p>The key of the tag.</p>\"\
        },\
        \"TagValue\":{\
          \"shape\":\"TagValueType\",\
          \"documentation\":\"<p>The value of the tag.</p>\"\
        }\
      },\
      \"documentation\":\"<p>A key-value pair. A tag consists of a tag key and a tag value. Tag keys and tag values are both required, but tag values can be empty (null) strings.</p> <p>For information about the rules that apply to tag keys and tag values, see <a href=\\\"https://docs.aws.amazon.com/awsaccountbilling/latest/aboutv2/allocation-tag-restrictions.html\\\">User-Defined Tag Restrictions</a> in the <i>AWS Billing and Cost Management User Guide</i>.</p>\"\
    },\
    \"TagException\":{\
      \"type\":\"structure\",\
      \"members\":{\
        \"message\":{\"shape\":\"ErrorMessageType\"}\
      },\
      \"documentation\":\"<p>The request was rejected because one or more tags are not valid.</p>\",\
      \"exception\":true\
    },\
    \"TagKeyList\":{\
      \"type\":\"list\",\
      \"member\":{\"shape\":\"TagKeyType\"}\
    },\
    \"TagKeyType\":{\
      \"type\":\"string\",\
      \"max\":128,\
      \"min\":1\
    },\
    \"TagList\":{\
      \"type\":\"list\",\
      \"member\":{\"shape\":\"Tag\"}\
    },\
    \"TagResourceRequest\":{\
      \"type\":\"structure\",\
      \"required\":[\
        \"KeyId\",\
        \"Tags\"\
      ],\
      \"members\":{\
        \"KeyId\":{\
          \"shape\":\"KeyIdType\",\
          \"documentation\":\"<p>A unique identifier for the CMK you are tagging.</p> <p>Specify the key ID or the Amazon Resource Name (ARN) of the CMK.</p> <p>For example:</p> <ul> <li> <p>Key ID: <code>1234abcd-12ab-34cd-56ef-1234567890ab</code> </p> </li> <li> <p>Key ARN: <code>arn:aws:kms:us-east-2:111122223333:key/1234abcd-12ab-34cd-56ef-1234567890ab</code> </p> </li> </ul> <p>To get the key ID and key ARN for a CMK, use <a>ListKeys</a> or <a>DescribeKey</a>.</p>\"\
        },\
        \"Tags\":{\
          \"shape\":\"TagList\",\
          \"documentation\":\"<p>One or more tags. Each tag consists of a tag key and a tag value.</p>\"\
        }\
      }\
    },\
    \"TagValueType\":{\
      \"type\":\"string\",\
      \"max\":256,\
      \"min\":0\
    },\
    \"TrustAnchorCertificateType\":{\
      \"type\":\"string\",\
      \"max\":5000,\
      \"min\":1\
    },\
    \"UnsupportedOperationException\":{\
      \"type\":\"structure\",\
      \"members\":{\
        \"message\":{\"shape\":\"ErrorMessageType\"}\
      },\
      \"documentation\":\"<p>The request was rejected because a specified parameter is not supported or a specified resource is not valid for this operation.</p>\",\
      \"exception\":true\
    },\
    \"UntagResourceRequest\":{\
      \"type\":\"structure\",\
      \"required\":[\
        \"KeyId\",\
        \"TagKeys\"\
      ],\
      \"members\":{\
        \"KeyId\":{\
          \"shape\":\"KeyIdType\",\
          \"documentation\":\"<p>A unique identifier for the CMK from which you are removing tags.</p> <p>Specify the key ID or the Amazon Resource Name (ARN) of the CMK.</p> <p>For example:</p> <ul> <li> <p>Key ID: <code>1234abcd-12ab-34cd-56ef-1234567890ab</code> </p> </li> <li> <p>Key ARN: <code>arn:aws:kms:us-east-2:111122223333:key/1234abcd-12ab-34cd-56ef-1234567890ab</code> </p> </li> </ul> <p>To get the key ID and key ARN for a CMK, use <a>ListKeys</a> or <a>DescribeKey</a>.</p>\"\
        },\
        \"TagKeys\":{\
          \"shape\":\"TagKeyList\",\
          \"documentation\":\"<p>One or more tag keys. Specify only the tag keys, not the tag values.</p>\"\
        }\
      }\
    },\
    \"UpdateAliasRequest\":{\
      \"type\":\"structure\",\
      \"required\":[\
        \"AliasName\",\
        \"TargetKeyId\"\
      ],\
      \"members\":{\
        \"AliasName\":{\
          \"shape\":\"AliasNameType\",\
          \"documentation\":\"<p>Specifies the name of the alias to change. This value must begin with <code>alias/</code> followed by the alias name, such as <code>alias/ExampleAlias</code>.</p>\"\
        },\
        \"TargetKeyId\":{\
          \"shape\":\"KeyIdType\",\
          \"documentation\":\"<p>Unique identifier of the customer master key (CMK) to be mapped to the alias. When the update operation completes, the alias will point to this CMK.</p> <p>Specify the key ID or the Amazon Resource Name (ARN) of the CMK.</p> <p>For example:</p> <ul> <li> <p>Key ID: <code>1234abcd-12ab-34cd-56ef-1234567890ab</code> </p> </li> <li> <p>Key ARN: <code>arn:aws:kms:us-east-2:111122223333:key/1234abcd-12ab-34cd-56ef-1234567890ab</code> </p> </li> </ul> <p>To get the key ID and key ARN for a CMK, use <a>ListKeys</a> or <a>DescribeKey</a>.</p> <p>To verify that the alias is mapped to the correct CMK, use <a>ListAliases</a>.</p>\"\
        }\
      }\
    },\
    \"UpdateCustomKeyStoreRequest\":{\
      \"type\":\"structure\",\
      \"required\":[\"CustomKeyStoreId\"],\
      \"members\":{\
        \"CustomKeyStoreId\":{\
          \"shape\":\"CustomKeyStoreIdType\",\
          \"documentation\":\"<p>Identifies the custom key store that you want to update. Enter the ID of the custom key store. To find the ID of a custom key store, use the <a>DescribeCustomKeyStores</a> operation.</p>\"\
        },\
        \"NewCustomKeyStoreName\":{\
          \"shape\":\"CustomKeyStoreNameType\",\
          \"documentation\":\"<p>Changes the friendly name of the custom key store to the value that you specify. The custom key store name must be unique in the AWS account.</p>\"\
        },\
        \"KeyStorePassword\":{\
          \"shape\":\"KeyStorePasswordType\",\
          \"documentation\":\"<p>Enter the current password of the <code>kmsuser</code> crypto user (CU) in the AWS CloudHSM cluster that is associated with the custom key store.</p> <p>This parameter tells AWS KMS the current password of the <code>kmsuser</code> crypto user (CU). It does not set or change the password of any users in the AWS CloudHSM cluster.</p>\"\
        },\
        \"CloudHsmClusterId\":{\
          \"shape\":\"CloudHsmClusterIdType\",\
          \"documentation\":\"<p>Associates the custom key store with a related AWS CloudHSM cluster. </p> <p>Enter the cluster ID of the cluster that you used to create the custom key store or a cluster that shares a backup history and has the same cluster certificate as the original cluster. You cannot use this parameter to associate a custom key store with an unrelated cluster. In addition, the replacement cluster must <a href=\\\"https://docs.aws.amazon.com/kms/latest/developerguide/create-keystore.html#before-keystore\\\">fulfill the requirements</a> for a cluster associated with a custom key store. To view the cluster certificate of a cluster, use the <a href=\\\"https://docs.aws.amazon.com/cloudhsm/latest/APIReference/API_DescribeClusters.html\\\">DescribeClusters</a> operation.</p>\"\
        }\
      }\
    },\
    \"UpdateCustomKeyStoreResponse\":{\
      \"type\":\"structure\",\
      \"members\":{\
      }\
    },\
    \"UpdateKeyDescriptionRequest\":{\
      \"type\":\"structure\",\
      \"required\":[\
        \"KeyId\",\
        \"Description\"\
      ],\
      \"members\":{\
        \"KeyId\":{\
          \"shape\":\"KeyIdType\",\
          \"documentation\":\"<p>A unique identifier for the customer master key (CMK).</p> <p>Specify the key ID or the Amazon Resource Name (ARN) of the CMK.</p> <p>For example:</p> <ul> <li> <p>Key ID: <code>1234abcd-12ab-34cd-56ef-1234567890ab</code> </p> </li> <li> <p>Key ARN: <code>arn:aws:kms:us-east-2:111122223333:key/1234abcd-12ab-34cd-56ef-1234567890ab</code> </p> </li> </ul> <p>To get the key ID and key ARN for a CMK, use <a>ListKeys</a> or <a>DescribeKey</a>.</p>\"\
        },\
        \"Description\":{\
          \"shape\":\"DescriptionType\",\
          \"documentation\":\"<p>New description for the CMK.</p>\"\
        }\
      }\
    },\
    \"WrappingKeySpec\":{\
      \"type\":\"string\",\
      \"enum\":[\"RSA_2048\"]\
    }\
  },\
  \"documentation\":\"<fullname>AWS Key Management Service</fullname> <p>AWS Key Management Service (AWS KMS) is an encryption and key management web service. This guide describes the AWS KMS operations that you can call programmatically. For general information about AWS KMS, see the <a href=\\\"https://docs.aws.amazon.com/kms/latest/developerguide/\\\"> <i>AWS Key Management Service Developer Guide</i> </a>.</p> <note> <p>AWS provides SDKs that consist of libraries and sample code for various programming languages and platforms (Java, Ruby, .Net, macOS, Android, etc.). The SDKs provide a convenient way to create programmatic access to AWS KMS and other AWS services. For example, the SDKs take care of tasks such as signing requests (see below), managing errors, and retrying requests automatically. For more information about the AWS SDKs, including how to download and install them, see <a href=\\\"http://aws.amazon.com/tools/\\\">Tools for Amazon Web Services</a>.</p> </note> <p>We recommend that you use the AWS SDKs to make programmatic API calls to AWS KMS.</p> <p>Clients must support TLS (Transport Layer Security) 1.0. We recommend TLS 1.2. Clients must also support cipher suites with Perfect Forward Secrecy (PFS) such as Ephemeral Diffie-Hellman (DHE) or Elliptic Curve Ephemeral Diffie-Hellman (ECDHE). Most modern systems such as Java 7 and later support these modes.</p> <p> <b>Signing Requests</b> </p> <p>Requests must be signed by using an access key ID and a secret access key. We strongly recommend that you <i>do not</i> use your AWS account (root) access key ID and secret key for everyday work with AWS KMS. Instead, use the access key ID and secret access key for an IAM user. You can also use the AWS Security Token Service to generate temporary security credentials that you can use to sign requests.</p> <p>All AWS KMS operations require <a href=\\\"https://docs.aws.amazon.com/general/latest/gr/signature-version-4.html\\\">Signature Version 4</a>.</p> <p> <b>Logging API Requests</b> </p> <p>AWS KMS supports AWS CloudTrail, a service that logs AWS API calls and related events for your AWS account and delivers them to an Amazon S3 bucket that you specify. By using the information collected by CloudTrail, you can determine what requests were made to AWS KMS, who made the request, when it was made, and so on. To learn more about CloudTrail, including how to turn it on and find your log files, see the <a href=\\\"https://docs.aws.amazon.com/awscloudtrail/latest/userguide/\\\">AWS CloudTrail User Guide</a>.</p> <p> <b>Additional Resources</b> </p> <p>For more information about credentials and request signing, see the following:</p> <ul> <li> <p> <a href=\\\"https://docs.aws.amazon.com/general/latest/gr/aws-security-credentials.html\\\">AWS Security Credentials</a> - This topic provides general information about the types of credentials used for accessing AWS.</p> </li> <li> <p> <a href=\\\"https://docs.aws.amazon.com/IAM/latest/UserGuide/id_credentials_temp.html\\\">Temporary Security Credentials</a> - This section of the <i>IAM User Guide</i> describes how to create and use temporary security credentials.</p> </li> <li> <p> <a href=\\\"https://docs.aws.amazon.com/general/latest/gr/signature-version-4.html\\\">Signature Version 4 Signing Process</a> - This set of topics walks you through the process of signing a request using an access key ID and a secret access key.</p> </li> </ul> <p> <b>Commonly Used API Operations</b> </p> <p>Of the API operations discussed in this guide, the following will prove the most useful for most applications. You will likely perform operations other than these, such as creating keys and assigning policies, by using the console.</p> <ul> <li> <p> <a>Encrypt</a> </p> </li> <li> <p> <a>Decrypt</a> </p> </li> <li> <p> <a>GenerateDataKey</a> </p> </li> <li> <p> <a>GenerateDataKeyWithoutPlaintext</a> </p> </li> </ul>\"\
}\
";
}

@end
